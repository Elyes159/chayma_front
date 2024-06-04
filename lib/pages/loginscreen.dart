import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sagemcom/api/apiclient.dart';
import 'package:sagemcom/pages/forgetpasswordscreen.dart';
import 'package:sagemcom/pages/registerscreen.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 183, 210, 239),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset("assets/sagem.png", height: 150, width: 400),
                const SizedBox(height: 29),
                Form(
                  child: Column(
                    children: [
                      const SizedBox(height: 29),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 300,
                        ),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 10, 10, 10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 70,
                          child: TextFormField(
                            controller: emailc,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
                                  .hasMatch(value)) {
                                return "please enter a valid email";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Color.fromARGB(255, 144, 140, 140),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "username@gmail.com",
                              prefixIcon: Icon(Icons.email,
                                  size: 26,
                                  color: Color.fromARGB(255, 69, 166, 235)),
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 14, 14, 14),
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
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 270,
                        ),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 144, 140, 140),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 67,
                          child: TextFormField(
                            controller: passwordc,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                                return "please enter a valid password";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "********",
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 9),
                                child: Icon(Icons.lock,
                                    size: 26,
                                    color: Color.fromARGB(255, 63, 173, 246)),
                              ),
                              suffixIcon: Icon(Icons.visibility,
                                  size: 26,
                                  color: Color.fromARGB(255, 54, 167, 241)),
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
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 210),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen()));
                          },
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                              fontSize: 17.6,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 65, 176, 240),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28),
                        child: Container(
                          height: 54,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 80, 161, 226)),
                          child: CupertinoButton(
                            onPressed: () async {
                              // Your sign-in logic here
                              ApiClient.loginUser(
                                  context, emailc.text, passwordc.text);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 17.6,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 244, 245, 245),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 100,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Don't have account!",
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
                                        builder: (context) =>
                                            registerscreen()));
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 14.6,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 80, 161, 226),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
