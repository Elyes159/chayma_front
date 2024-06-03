import 'package:flutter/material.dart';
import 'package:sagemcom/api/apiclient.dart';

class AddTesteurscreen extends StatefulWidget {
  const AddTesteurscreen({Key? key}) : super(key: key);

  @override
  State<AddTesteurscreen> createState() => _AddTesteurscreenState();
}

class _AddTesteurscreenState extends State<AddTesteurscreen> {
  TextEditingController _nametetseurController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _hostController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cheminController = TextEditingController();
  TextEditingController _ligneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Add Tester',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white, // Couleur de fond de l'écran
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nametetseurController,
              decoration: InputDecoration(
                labelText: 'Nom du testeur',
                border: OutlineInputBorder(), // Bordure pour le champ de texte
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'username ',
                border: OutlineInputBorder(), // Bordure pour le champ de texte
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _hostController,
              decoration: InputDecoration(
                labelText: 'Hôte',
                border: OutlineInputBorder(), // Bordure pour le champ de texte
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _ligneController,
              decoration: InputDecoration(
                labelText: 'ligne',
                border: OutlineInputBorder(), // Bordure pour le champ de texte
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(), // Bordure pour le champ de texte
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _cheminController,
              decoration: InputDecoration(
                labelText: 'Chemin d\'accès',
                border: OutlineInputBorder(), // Bordure pour le champ de texte
              ),
            ),
            SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ApiClient.insertTesteur(
                      context: context,
                      name: _nametetseurController.text,
                      username: _usernameController.text,
                      ligne: _ligneController.text,
                      host: _hostController.text,
                      password: _passwordController.text,
                      chemin: _cheminController.text);
                },
                child: Text('Enregistrer'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Couleur du texte du bouton
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0), // Espacement interne du bouton
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
