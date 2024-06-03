import 'package:flutter/material.dart';
import 'package:sagemcom/api/apiclient.dart';
import 'package:sagemcom/pages/EditProfilScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  String? email;
  String? prenom;
  String? nom;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      prenom = prefs.getString('prenom');
      nom = prefs.getString('nom');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 232, 233),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                "assets/sagem.png",
                height: 150,
                width: 400,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text(
                'prenom',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${prenom ?? ''}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // Vous pouvez remplacer ceci par un champ dynamique si nécessaire
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text(
                'nom',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${nom ?? ''}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // Vous pouvez remplacer ceci par un champ dynamique si nécessaire
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('Email'),
              subtitle: Text('$email'), // Champ statique pour l'exemple
            ),
            SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.lock, color: Colors.blue),
              title: Text('Password'),
              subtitle: Text('••••••••'), // Champ statique pour l'exemple
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen()),
                  );
                },
                icon: Icon(Icons.edit),
                label: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
