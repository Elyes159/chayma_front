import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextEditingController emailController = TextEditingController();
final forgetFormKey = GlobalKey<FormState>();

class forgetpasswordscreen extends StatefulWidget {
  const forgetpasswordscreen({Key? key});

  @override
  State<forgetpasswordscreen> createState() => _forgetpasswordscreenState();
}

class _forgetpasswordscreenState extends State<forgetpasswordscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 183, 210, 239),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset("assets/sagem.png", height: 150, width: 400),
                const SizedBox(height: 25),
                Form(
                  key: forgetFormKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Text(
                          "Enter your email to access a link  \n          to reset your password",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
                                  .hasMatch(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "username@gmail.com",
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Icon(Icons.email, size: 26, color: Color.fromARGB(255, 69, 166, 235)),
                              ),
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
                            onPressed: () {
                              if (forgetFormKey.currentState!.validate()) {
                                // Action à effectuer lors de la validation du formulaire
                              }
                            },
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                fontSize: 17.6,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
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
