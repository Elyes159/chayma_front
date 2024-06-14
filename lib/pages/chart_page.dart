import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<double> fpyValues =
      []; // Liste pour stocker les valeurs de fpy depuis l'API

  @override
  void initState() {
    super.initState();
    fetchData(); // Appel à la méthode pour charger les données initiales depuis l'API
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://192.168.1.17:8000/performance-data/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final indicateurs = jsonData['indicateurs'];

      if (indicateurs.isNotEmpty) {
        setState(() {
          fpyValues = indicateurs.map<double>((indicateur) {
            final value = indicateur['fpy'];
            return value is double
                ? value
                : double.tryParse(value.toString()) ?? 0.0;
          }).toList();
        });
      } else {
        // Si le tableau est vide, générer des valeurs aléatoires pour simuler les données
        setState(() {
          fpyValues = List.generate(8, (index) => Random().nextDouble() * 70);
        });
      }
    } else {
      // En cas d'échec, générer des valeurs aléatoires pour simuler les données
      setState(() {
        fpyValues = List.generate(6, (index) => Random().nextDouble() * 70);
      });

      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 70,
                    barGroups: fpyValues
                        .asMap()
                        .map((index, value) => MapEntry(
                              index,
                              BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: value,
                                    color: Colors.blue,
                                    width: 16,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ],
                              ),
                            ))
                        .values
                        .toList(),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(' ${(value.toInt() + 1)}');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: fpyValues
                            .asMap()
                            .map((index, value) => MapEntry(
                                  index,
                                  FlSpot(index.toDouble(), value),
                                ))
                            .values
                            .toList(),
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 4,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text('Item ${(value.toInt() + 1)}');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    gridData: FlGridData(show: true),
                    minX: 0,
                    maxX: fpyValues.length.toDouble() - 1,
                    maxY: fpyValues.isEmpty ? 70 : fpyValues.reduce(max) + 10,
                    minY: fpyValues.isEmpty ? 0 : fpyValues.reduce(min) - 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
