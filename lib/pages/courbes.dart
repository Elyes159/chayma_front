import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Function Curve Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Courbe de la Fonction f(x) en Flutter'),
        ),
        body: CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: FunctionCurvePainter(),
        ),
      ),
    );
  }
}

class FunctionCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();

    // Définir la fonction f(x) ici
    double function(double x) {
      return 100 * sin(x); // Exemple : sinusoïde
    }

    // Dessiner la courbe en utilisant des points discrets
    double xStep = 0.1; // Intervalle de points
    double startX = 0;
    double endX = size.width;

    // Commencer le chemin à la position initiale
    path.moveTo(startX, size.height / 2 - function(startX));

    // Ajouter les points de la courbe
    for (double x = startX; x <= endX; x += xStep) {
      path.lineTo(x, size.height / 2 - function(x));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
