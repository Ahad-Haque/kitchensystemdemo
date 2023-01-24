import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:kitchen_graph/salesvalue.dart';
import 'package:kitchen_graph/saletime.dart';

class Graphchart extends StatefulWidget {
  Graphchart({super.key});
  final databasereference = FirebaseDatabase.instance.ref("maindata");

  @override
  State<Graphchart> createState() => _GraphchartState();
}

class _GraphchartState extends State<Graphchart> {
  //documnet id
  List<String> docIDS = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('maindata')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDS.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIDS.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Salesvalue(documentId: docIDS[index]));
                  });
            },
          )),
          Expanded(
              child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIDS.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Saletime(documentIDval: docIDS[index]));
                  });
            },
          )),
          Container(
            height: 400,
            width: 350,
            color: Colors.transparent,
            child: Linechartwidget(),
          )
        ],
      ),
    );
  }
}

//linechart drawing
class Linechartwidget extends StatelessWidget {
  Linechartwidget({super.key});
  // var graphchart = _GraphchartState();
  // var salvalue = Salesvalue(documentId: graphchart.docIDS[2]);

  @override
  Widget build(BuildContext context) => LineChart(
          LineChartData(minX: 0, maxX: 11, minY: 0, maxY: 6, lineBarsData: [
        LineChartBarData(spots: [
          FlSpot(1, 5),
          FlSpot(4, 5),
          FlSpot(6, 4),
          FlSpot(7, 2),
        ])
      ]));
}
