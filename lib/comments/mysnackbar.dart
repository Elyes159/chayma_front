import 'package:flutter/material.dart';

void showSnackbar(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.amber,
    content:Text(text)));
}