
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartsExample extends StatefulWidget {
  @override
  _ChartsExampleState createState() => _ChartsExampleState();
}

class _ChartsExampleState extends State<ChartsExample> {
  late List<charts.Series<ChartData, String>> _seriesList;
  late bool _animate;

  @override
  void initState() {
    super.initState();
    //_seriesList = _createSampleData();
    _seriesList = [
      charts.Series<ChartData, String>(
        id: 'Sales',
        domainFn: (ChartData sales, _) => sales.year,
        measureFn: (ChartData sales, _) => sales.sales,
        data: [
          ChartData('2014', 5),
          ChartData('2015', 25),
          ChartData('2016', 100),
          ChartData('2017', 75),
        ],
      )
    ];
    _animate = true;
  }

  // static List<charts.Series<ChartData, String>> _createSampleData() {
  //   final data = [
  //     ChartData('2014', 5),
  //     ChartData('2015', 25),
  //     ChartData('2016', 100),
  //     ChartData('2017', 75),
  //   ];

  //   return [
  //     charts.Series<ChartData, String>(
  //       id: 'Sales',
  //       domainFn: (ChartData sales, _) => sales.year,
  //       measureFn: (ChartData sales, _) => sales.sales,
  //       data: data,
  //     )
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Charts Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  child: charts.BarChart(
                    _seriesList,
                    animate: _animate,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  child: charts.PieChart(
                    _seriesList,
                    animate: _animate,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  child: charts.LineChart(
                    _seriesList.cast<charts.Series<dynamic, num>>(),
                    animate: _animate,
                    defaultRenderer:
                        charts.LineRendererConfig(includePoints: true),
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

class ChartData {
  final String year;
  final int sales;

  ChartData(this.year, this.sales);
}
