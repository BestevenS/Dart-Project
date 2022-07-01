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
      home: Heartrate(),
    );
  }
}

class Heartrate extends StatefulWidget {
  Heartrate({Key key}) : super(key: key);

  @override
  _HeartrateState createState() => _HeartrateState();
}

class _HeartrateState extends State<Heartrate> {
  List<MyData> chartData = [];

  Future<String> _loadMyDataAsset() async {
    return await rootBundle.loadString('data_repo/heartrate.json');
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
        id: "Heartrate",
        data: chartData,
        domainFn: (MyData myData, _) => myData.dateTime,
        measureFn: (MyData myData, _) => myData.heartRate,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.cyan),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
          title: Text("HeartRate")
      ),
      body: Container(
        // height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Column(
            children: <Widget>[
              Text(
                "Heart Rate",
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyData {
  MyData(this.dateTime, this.heartRate);

  final String dateTime;
  final double heartRate;

  factory MyData.fromJson(Map<String, dynamic> parsedJson) {
    return MyData(
      parsedJson['dateTime'] as String,
      parsedJson['heartRate'] as double,
    );
  }
}