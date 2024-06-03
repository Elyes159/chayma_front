import 'dart:async';

import 'package:sagemcom/pages/loginscreen.dart';
import 'package:flutter/material.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 4),()=>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginscreen())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 178, 212, 232),
      body: Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 290),
            Image.asset("assets/sagem.png",height: 200,width: 1000),
        

             
          ]),
      ),
      )


    );
  }
}