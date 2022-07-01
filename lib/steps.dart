import 'dart:convert';
import 'dart:async' show Future;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Demo',
      home: Steps(),
    );
  }
}

class Steps extends StatefulWidget {
  Steps({Key key}) : super(key: key);

  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  List<MyData> chartData = [];

  Future<String> _loadMyDataAsset() async {
    return await rootBundle.loadString('data_repo/response_calories_steps.json');
  }

  Future loadMyData() async {
    String jsonString = await _loadMyDataAsset();
    final jsonResponse = json.decode(jsonString);
    print(jsonResponse);
    setState(() {
      for(Map i in jsonResponse) {
        chartData.add(MyData.fromJson(i));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyData();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<MyData, String>> series = [
      charts.Series(
        id: "Steps",
        data: chartData,
        domainFn: (MyData mydata, _) => mydata.startTime,
        measureFn: (MyData mydata, _) => mydata.steps,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.brown),
      ),
      charts.Series(
        id: "Calories",
        data: chartData,
        domainFn: (MyData mydata, _) => mydata.startTime,
        measureFn: (MyData mydata, _) => mydata.calories,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.cyan),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
          title: Text("Steps")
      ),
      body: Container(
        // height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Column(
            children: <Widget>[
              Text(
                "Steps",
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),  //GroupedBarChart
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyData {
  MyData(this.startTime,this.calories, this.steps);

  final String startTime;
  final int calories;
  final int steps;

  factory MyData.fromJson(Map<String, dynamic> parsedJson,) {
    return MyData(
      parsedJson['startTime'].substring(5,10),
      parsedJson['calories'],
      parsedJson['steps'],
    );
  }
}