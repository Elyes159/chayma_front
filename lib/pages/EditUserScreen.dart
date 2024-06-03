import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditUserScreen extends StatefulWidget {


  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = 'John Doe';
  String _email = 'john.doe@example.com';
  String _password = 'password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 245, 246),
      appBar: AppBar(
       backgroundColor: Colors.blue,
        title: Text('Edit User'),
        
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
                initialValue: _username,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  icon: Icon(Icons.person, color: Colors.blue),
                ),
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  icon: Icon(Icons.email, color: Colors.blue),
                ),
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                initialValue: _password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  icon: Icon(Icons.lock, color: Colors.blue),
                ),
                obscureText: true,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save the updated profile information
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16.0, // Taille de la police
                    fontWeight: FontWeight.bold, // Épaisseur de la police
                    color: const Color.fromARGB(255, 248, 247, 247), // Couleur du texte
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, disabledForegroundColor: Colors.blueAccent.withOpacity(0.38), disabledBackgroundColor: Colors.blueAccent.withOpacity(0.12), // Color when the button is pressed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
