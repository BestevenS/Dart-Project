import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './main_drawer.dart';
import 'package:intl/intl.dart';

class Demographics extends StatefulWidget {
  Demographics({Key key}) : super(key: key);

  @override
  _DemographicsState createState() => _DemographicsState();
}

class _DemographicsState extends State<Demographics> {
  Map<String, dynamic> jsonData;
  List<MyData> profileData = [];

  Future<String> _loadMyDataAsset() async {
    return await rootBundle.loadString('data_repo/profile.json');
  }
  bool boolean = true;
  Future loadMyData() async {
    String jsonString = await _loadMyDataAsset();
    setState(() {
      final jsonResponse = json.decode(jsonString);
      jsonData = jsonResponse['user'];
      print(jsonData);
      boolean = false;
    });
  }

  @override
  void initState() {
  super.initState();
  loadMyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Demographics")
      ),
      body: boolean
      ? Center(
        child: CircularProgressIndicator(), //o loader
      )
      : Center(
          child: Container(
            alignment: Alignment(0, 0.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  jsonData['avatar'],
                )
              ),
            ),
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: jsonData['fullName'],
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: jsonData['dateOfBirth'],
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
    );
  }
}

class MyData {
  MyData(this.fullName, this.dateOfBirth, this.avatar);

  final String fullName;
  final DateTime dateOfBirth;
  final String avatar;

  factory MyData.fromJson(Map<String, dynamic> parsedJson) {
    return MyData(
      parsedJson['fullName'],
      parsedJson['dateOfBirth'],
      parsedJson['avatar150'],
    );
  }
}