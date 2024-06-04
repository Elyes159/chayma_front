import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sagemcom/api/apiclient.dart';
import 'package:url_launcher/url_launcher.dart';

TextEditingController emailController = TextEditingController();
final forgetFormKey = GlobalKey<FormState>();

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  void _launchURL() async {
    const url =
        "${ApiClient.baseUrl}/reset_password/"; // Remplacez cette URL par celle de votre lien de réinitialisation de mot de passe
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                          child: TextButton(
                            onPressed: _launchURL,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(20.0),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                                side: BorderSide(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.link,
                                    size: 26,
                                    color: Color.fromARGB(255, 69, 166, 235)),
                                SizedBox(width: 20),
                                Text(
                                  "Go to reset link",
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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
