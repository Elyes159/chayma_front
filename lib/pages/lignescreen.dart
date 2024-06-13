import 'package:flutter/material.dart';
import 'package:sagemcom/pages/chart_page.dart';

class LigneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ligne'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Action pour le premier bouton
              },
              child: Text('Button 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChartPage()),
                );
              },
              child: Text('Button 2'),
            ),
            ElevatedButton(
              onPressed: () {
                // Action pour le deuxième bouton
              },
              child: Text('Button 2'),
            ),
            // Ajoutez plus de boutons si nécessaire
          ],
        ),
      ),
    );
  }
}
