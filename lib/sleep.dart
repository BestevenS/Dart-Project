import 'dart:convert';
import 'dart:async' show Future;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:drawer/demographics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Demo',
      home: Sleep(),
    );
  }
}

class Sleep extends StatefulWidget {
  Sleep({Key key}) : super(key: key);

  @override
  _SleepState createState() => _SleepState();
}

class _SleepState extends State<Sleep> {
  List<MyData> chartData = [];

  Future<String> _loadMyDataAsset() async {
    return await rootBundle.loadString('data_repo/sleepData.json');
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
        id: "Sleep",
        data: chartData,
        domainFn: (MyData mydata, _) => mydata.dateOfSleep,
        measureFn: (MyData mydata, _) => (mydata.duration/1000)/60,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.cyan),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
          title: Text("Sleep")
      ),
      body: Container(
        // height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Column(
            children: <Widget>[
              Text(
                "Sleep",
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
  MyData(this.dateOfSleep, this.duration);

  final String dateOfSleep;
  final int duration;

  factory MyData.fromJson(Map<String, dynamic> parsedJson) {
    return MyData(
      parsedJson['dateOfSleep'] as String,
      parsedJson['duration'] as int,
    );
  }
}