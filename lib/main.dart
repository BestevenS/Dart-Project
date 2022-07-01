import 'package:flutter/material.dart';
import './demographics.dart';
import './HomePage.dart';
import './heartrate.dart';
import './steps.dart';
import './sleep.dart';
import './demographics.dart';

void main() {
  runApp(
      MaterialApp(
        title: "Dashboard",
        routes: {
          '/':(context)=>MyHomePage(),
          '/steps':(context)=>Steps(),
          '/heartrate':(context)=>Heartrate(),
          '/sleep':(context)=>Sleep(),
          '/demographics':(context)=>Demographics(),
        },
      )
  );
}