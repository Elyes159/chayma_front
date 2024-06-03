import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sagemcom/api/apiclient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, this.nom, this.prenom, this.email})
      : super(key: key);
  final String? nom;
  final String? prenom;

  final String? email;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _initializeControllers();
  }

  Future<void> _initializeControllers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? prenom = prefs.getString('prenom');
    final String? nom = prefs.getString('nom');

    final String? emailP = widget.email;
    final String? prenomP = widget.prenom;
    final String? nomP = widget.nom;

    // Vérifier si la navigation vient de la page de connexion
    if (widget.email != null && widget.prenom != null && widget.nom != null) {
      setState(() {
        _usernameController.text = prenomP ?? '';
        _emailController.text = emailP ?? '';
        _passwordController.text = nomP ?? '';
      });
    } else {
      setState(() {
        _usernameController.text = prenom ?? '';
        _emailController.text = email ?? '';
        _passwordController.text = nom ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 245, 246),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Image.asset("assets/sagem.png", height: 150, width: 400),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "prenom",
                  labelStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  icon: Icon(Icons.person, color: Colors.blue),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'nom',
                  labelStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  icon: Icon(Icons.person, color: Colors.blue),
                ),
                // obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "email",
                  labelStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  icon: Icon(Icons.email, color: Colors.blue),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Récupérez les valeurs des contrôleurs de texte
                    String username = _usernameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    if (widget.email != null &&
                        widget.prenom != null &&
                        widget.nom != null) {
                      ApiClient.updateUserProfileAdmin(
                        prenom: username,
                        nom: password,
                        emaill: email,
                      ).then((_) {
                        Navigator.pop(context);
                      });
                    } else {
                      ApiClient.updateUserProfile(
                        prenom: username,
                        nom: password,
                        emaill: email,
                      ).then((_) {
                        // Une fois la mise à jour terminée avec succès, fermez l'écran
                        Navigator.pop(context);
                      });
                    }
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 248, 247, 247),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  disabledForegroundColor: Colors.blueAccent.withOpacity(0.38),
                  disabledBackgroundColor: Colors.blueAccent.withOpacity(0.12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Disposez des contrôleurs de texte lorsque l'écran est supprimé
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
