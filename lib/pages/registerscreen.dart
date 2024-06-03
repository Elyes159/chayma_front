import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sagemcom/api/apiclient.dart';
import 'package:sagemcom/pages/loginscreen.dart';

TextEditingController nomController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController prenomController = TextEditingController();
TextEditingController password1Contorller = TextEditingController();
TextEditingController password2Contorller = TextEditingController();

final registerFormKey = GlobalKey<FormState>();

class registerscreen extends StatefulWidget {
  const registerscreen({super.key});

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 183, 210, 239),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset("assets/sagem.png", height: 150, width: 400),
                const SizedBox(height: 29),
                Form(
                  key: registerFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 9),
                      const Padding(
                        padding: EdgeInsets.only(right: 300),
                        child: Text(
                          "Nom",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 60,
                          child: TextFormField(
                            controller: nomController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name cannot be empty";
                              }
                              if (!RegExp(r'^[a-z- A-Z]+$').hasMatch(value)) {
                                return "Please enter a valid Name";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "nom",
                              prefixIcon: Icon(Icons.person,
                                  size: 26,
                                  color: Color.fromARGB(255, 63, 173, 246)),
                              hintStyle: const TextStyle(
                                color: Color(0xFF9B9B9B),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Email Field
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.only(right: 300),
                        child: Text(
                          "prenom",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 60,
                          child: TextFormField(
                            controller: prenomController,
                            validator: (value) {
                              // Validator logic for email
                              // You can customize it according to your requirements
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "prenom",
                              prefixIcon: Icon(Icons.email,
                                  size: 26,
                                  color: Color.fromARGB(255, 63, 173, 246)),
                              hintStyle: const TextStyle(
                                color: Color(0xFF9B9B9B),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 300),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 60,
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              // Validator logic for email
                              // You can customize it according to your requirements
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "username@gmail.com",
                              prefixIcon: Icon(Icons.email,
                                  size: 26,
                                  color: Color.fromARGB(255, 63, 173, 246)),
                              hintStyle: const TextStyle(
                                color: Color(0xFF9B9B9B),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Password Field
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.only(right: 300),
                        child: Text(
                          "password",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 60,
                          child: TextFormField(
                            controller: password1Contorller,
                            validator: (value) {
                              // Validator logic for password
                              // You can customize it according to your requirements
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "********",
                              prefixIcon: Icon(Icons.lock,
                                  size: 26,
                                  color: Color.fromARGB(255, 63, 173, 246)),
                              suffixIcon: const Icon(Icons.visibility,
                                  size: 26,
                                  color: Color.fromARGB(255, 63, 173, 246)),
                              hintStyle: const TextStyle(
                                color: Color(0xFF9B9B9B),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Ajouter les autres champs du formulaire ici...
                      const Padding(
                        padding: EdgeInsets.only(right: 300),
                        child: Text(
                          "Confirmer password",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 60,
                          child: TextFormField(
                            controller: password2Contorller,
                            validator: (value) {
                              // Validator logic for password
                              // You can customize it according to your requirements
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "********",
                              prefixIcon: Icon(Icons.lock,
                                  size: 26,
                                  color: Color.fromARGB(255, 63, 173, 246)),
                              suffixIcon: const Icon(Icons.visibility,
                                  size: 26,
                                  color: Color.fromARGB(255, 63, 173, 246)),
                              hintStyle: const TextStyle(
                                color: Color(0xFF9B9B9B),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 54,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 80, 161, 226),
                          ),
                          child: CupertinoButton(
                            onPressed: () async {
                              if (registerFormKey.currentState!.validate()) {
                                ApiClient.registerUser(
                                    context,
                                    prenomController.text,
                                    nomController.text,
                                    emailController.text,
                                    password1Contorller.text,
                                    password2Contorller.text);
                              }
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 17.6,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 100),
                        child: Row(
                          children: [
                            Text(
                              "If You have account!",
                              style: TextStyle(
                                fontSize: 14.6,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => loginscreen()));
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 14.6,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 63, 173, 246),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
