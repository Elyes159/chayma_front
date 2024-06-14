import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sagemcom/pages/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const baseUrl = 'http://192.168.1.17:8000';
  static Future<void> registerUser(BuildContext context, String prenom,
      String nom, String email, String password1, String password2) async {
    final url = Uri.parse('$baseUrl/register/');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'password1': password1,
      'password2': password2,
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('prenom', prenom);
      await prefs.setString('email', nom);
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        // User registered successfully
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseData['message'])));
      } else if (response.statusCode == 400) {
        // Error during registration
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData['error'] ?? 'Registration failed')));
      } else {
        // Unexpected status code
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Server error: ${response.statusCode}')));
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Network error: $e')));
    }
  }

  static final storage = FlutterSecureStorage();

  static Future<void> loginUser(
      BuildContext context, String email, String password) async {
    final url = Uri.parse('$baseUrl/api/token/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.post(url, headers: headers, body: body);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String accessToken = responseData['access'];
        String refreshToken = responseData['refresh'];

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login successful')));

        // Store the tokens for future requests
        await storage.write(key: 'access_token', value: accessToken);
        await storage.write(key: 'refresh_token', value: refreshToken);

        // Store the email in SharedPreferences
        await prefs.setString('email', email);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => homescreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['error'] ?? 'Login failed')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred')));
    }
  }

  static Future<String?> _getToken(String key) async {
    return await storage.read(key: key);
  }

  static Future<void> updateUserProfile({
    required String prenom,
    required String nom,
    required String emaill,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String profileUrl = '$baseUrl/api/profile/$email/';

    try {
      Map<String, dynamic> userData = {
        'prenom': prenom,
        'nom': nom,
        'email': emaill,
      };

      final response = await http.post(
        Uri.parse(profileUrl),
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully ${response.statusCode}');
      } else {
        print('Failed to update profile ${response.statusCode}');
        print("######################################");

        print("Request Body: ${response.headers}");
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<void> updateUserProfileAdmin({
    required String prenom,
    required String nom,
    required String emaill,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String profileUrl = '$baseUrl/api/profile_admin/$email/';

    try {
      Map<String, dynamic> userData = {
        'prenom': prenom,
        'nom': nom,
        'email': emaill,
      };

      final response = await http.post(
        Uri.parse(profileUrl),
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully ${response.statusCode}');
      } else {
        print('Failed to update profile ${response.statusCode}');
        print("######################################");

        print("Request Body: ${response.headers}");
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<Map<String, dynamic>> fetchUsers(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final url = Uri.parse('$baseUrl/users_app/$email/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      return userData;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load users: ${response.statusCode}')));
      return {}; // Retourner une carte vide en cas d'erreur
    }
  }

  static Future<List<dynamic>> fetchTesteurs(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final url = Uri.parse('$baseUrl/list_testeurs_app/$email/');
    final response =
        await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("${data["testeurs"]}");
      return data['testeurs'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load testeurs: ${response.statusCode}')));
      return [];
    }
  }

  static Future<void> insertTesteur({
    required BuildContext context,
    required String name,
    required String username,
    required String ligne,
    required String host,
    required String password,
    required String chemin,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final url = Uri.parse('$baseUrl/inserttesteur_app/$email/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
      'name': name,
      'username': username,
      'ligne': ligne,
      'host': host,
      'password': password,
      'chemin': chemin,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Testeur inserted successfully')),
        );
      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(responseData['error'] ?? 'Failed to insert testeur')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  static Future<void> addUser({
    required BuildContext context,
    required String prenom,
    required String nom,
    required String email,
    required String password1,
    required String password2,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? adminEmail = prefs.getString('email');
    final url = Uri.parse('$baseUrl/adduser_app/$adminEmail/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'password1': password1,
      'password2': password2,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User added successfully')),
        );
      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  responseData['errors']?.toString() ?? 'Failed to add user')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  static Future<void> deleteTesteur({
    required BuildContext context,
    required int testeurId,
  }) async {
    final url = Uri.parse('$baseUrl/delete_testeur/$testeurId/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Testeur deleted successfully')),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Testeur not found')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete testeur')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  static Future<void> editTesteur({
    required BuildContext context,
    required int testeurId,
    required Map<String, String> data,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final url = Uri.parse('$baseUrl/edit_testeur_app/$email/$testeurId/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Testeur updated successfully')),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Testeur not found')),
        );
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body)['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update testeur')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  static Future<void> deleteUser(BuildContext context, String email) async {
    final url = Uri.parse('$baseUrl/delete_user_app/$email/');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User deleted successfully')),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not found')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete user')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  static Future<void> approveUser({
    required BuildContext context,
    required String email,
  }) async {
    final url = Uri.parse('$baseUrl/approve_app/$email/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('user approved  successfully')),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('user not found')),
        );
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body)['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve user')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  static Future<Map<String, dynamic>> fetchPerformanceData() async {
    final url = Uri.parse('$baseUrl/performance-data/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
