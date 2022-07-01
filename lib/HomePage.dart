import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'main_drawer.dart';


void main() => runApp(
    MaterialApp(
        title:"Dashboard",
        home:MyHomePage()
    )
);

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(430.0, Colors.blue, rankKey: 'Q1'),
        new CircularSegmentEntry(100.0, Colors.orange, rankKey: 'Q2'),
        new CircularSegmentEntry(180.0, Colors.red, rankKey: 'Q3'),
        new CircularSegmentEntry(100.0, Colors.green, rankKey: 'Q4'),
      ],
    ),
  ];



  Widget myCircularItems(String title){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.grey,
      child: Center(
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                mainAxisAlignment:MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Text(
                      title,
                      style:TextStyle(
                        fontSize: 25.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),

                  Padding(
                    padding:EdgeInsets.fromLTRB(1,75,1,1),
                    child:AnimatedCircularChart( //το widget που μας δινει το package flutter_circular_chart.dart
                      size: Size(100.0, 100.0),
                      initialChartData: circularData,
                      chartType: CircularChartType.Pie, //εδω δηλωνουμε τον τυπο του γραφηματος
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //το widgets για να φτιαξουμε το πρωτο γραφημα σε μορφη γραμμης
  Widget mychart1Items(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.grey,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(title, style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(1,40,1,1),
                      child: new Sparkline(  //το γραφημε σε μορφη γραμμης
                        data: data, // τα double δεδομενα που εχουμε δηλωσει στην αρχη
                        lineColor: Colors.red,
                        pointsMode: PointsMode.all, //δειχνει τα σημεια με τις τιμες σαν βουλες/points
                        pointSize: 8.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //το widgets για να φτιαξουμε το τελευταιο γραφημα σε μορφη γραμμης
  //ειναι το ιδιο με το πρωτο γραφημα απλα εδω γεμιζουμε την περιοχη κατω απο την γραμμη
  Widget mychart2Items(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor:Colors.grey,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        title, style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Image.asset('assets/images/profile.png',width: 50),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mychart3Items(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor:Colors.grey,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        title, style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Image.asset('assets/images/sleepIcon.png',width: 50),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body:Container(
        color:Colors.white,
        child:StaggeredGridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: mychart1Items("Heart Rate"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myCircularItems("Steps"),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: mychart2Items("Me"),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: mychart3Items("Sleep"),
            ),

          ],
          staggeredTiles: [
            StaggeredTile.extent(4, 250.0),
            StaggeredTile.extent(2, 312),
            StaggeredTile.extent(2, 150),
            StaggeredTile.extent(2, 150),
          ],
        ),
      ),
    );
  }
}