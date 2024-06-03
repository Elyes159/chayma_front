import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sagemcom/api/apiclient.dart';

class EditTesteurscreen extends StatefulWidget {
  const EditTesteurscreen(
      {super.key,
      this.name,
      this.username,
      this.host,
      this.path,
      this.password,
      this.ligne,
      required this.id});
  final String? name;
  final String? username;
  final String? host;
  final String? path;
  final String? password;
  final String? ligne;
  final int id;

  @override
  State<EditTesteurscreen> createState() => _EditTesteurscreenState();
}

class _EditTesteurscreenState extends State<EditTesteurscreen> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _hostController;
  late TextEditingController _passwordController;
  late TextEditingController _pathController;
  late TextEditingController _ligneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _usernameController = TextEditingController(text: widget.username);
    _hostController = TextEditingController(text: widget.host);
    _passwordController = TextEditingController(text: widget.password);
    _pathController = TextEditingController(text: widget.path);
    _ligneController = TextEditingController(text: widget.ligne);
  }

  void _updateTester(String updatedName, String updatedUsername,
      String updatedHost, String updatedPassword, String updatedChemin) {
    setState(() {});
    // Ajoutez ici la logique pour mettre à jour les informations du testeur dans votre source de données
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Edit Tester',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildStyledTextField(
              label: 'Name',
              icon: Icons.person,
              initialValue: _nameController.text,
              onChanged: (value) {
                _nameController.text = value;
              },
            ),
            SizedBox(height: 20),
            _buildStyledTextField(
              label: 'Username',
              icon: Icons.account_circle,
              initialValue: _usernameController.text,
              onChanged: (value) {
                _usernameController.text = value;
              },
            ),
            SizedBox(height: 20),
            _buildStyledTextField(
              label: 'Host',
              icon: Icons.cloud,
              initialValue: _hostController.text,
              onChanged: (value) {
                _hostController.text = value;
              },
            ),
            SizedBox(height: 20),
            _buildStyledTextField(
              label: 'Password',
              icon: Icons.lock,
              initialValue: _passwordController.text,
              obscureText: true,
              onChanged: (value) {
                _passwordController.text = value;
              },
            ),
            SizedBox(height: 20),
            _buildStyledTextField(
              label: 'Path',
              icon: Icons.folder,
              initialValue: _pathController.text,
              onChanged: (value) {
                _pathController.text = value;
              },
            ),
            SizedBox(height: 20),
            _buildStyledTextField(
              label: 'ligne',
              icon: Icons.folder,
              initialValue: _ligneController.text,
              onChanged: (value) {
                _ligneController.text = value;
              },
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final data = {
                    'name': _nameController.text,
                    'username': _usernameController.text,
                    'host': _hostController.text,
                    'password': _passwordController.text,
                    'chemin': _pathController.text,
                    'ligne': _ligneController.text,
                  };
                  ApiClient.editTesteur(
                    context: context,
                    testeurId: widget.id,
                    data: data,
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ), // Couleur du texte
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledTextField({
    required String label,
    required IconData icon,
    required String initialValue,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      controller: TextEditingController(text: initialValue),
      onChanged: onChanged,
      obscureText: obscureText,
    );
  }
}
