import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class TgRevenue extends StatelessWidget {
  const TgRevenue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          LimitedBox(
            maxWidth: 500,
            maxHeight: 500,
            child: DChartBar(
              axisLineColor: Colors.green,
              borderColor: Colors.red,
              barValueColor: Colors.grey,
              xAxisTitleColor: Colors.blue,
              yAxisTitleColor: Colors.orange,
              domainLabelColor: Colors.purple,
              measureLabelColor: Colors.brown,
              barColor: (a,b,c) => Colors.blue,
              data: const[
                {
                  "id": "1",
                  "data": [
                    {"domain": "jan", "measure": 10},
                    {"domain": "feb", "measure": 20},
                    {"domain": "mar", "measure": 30},
                    {"domain": "apr", "measure": 40},
                    {"domain": "may", "measure": 50},
                    {"domain": "jun", "measure": 60},
                    {"domain": "jul", "measure": 70},
                    {"domain": "aug", "measure": 80},
                    {"domain": "sep", "measure": 90},
                    {"domain": "okt", "measure": 100},
                    {"domain": "nov", "measure": 110},
                    {"domain": "des", "measure": 120},
                  ],
                },
                {
                "id": "2",
                "data": [
                  {"domain": "jan2", "measure": 100},
                  {"domain": "feb2", "measure": 220},
                  {"domain": "mar2", "measure": 340},
                  {"domain": "apr2", "measure": 460},
                  {"domain": "may2", "measure": 520},
                  {"domain": "jun2", "measure": 670},
                  {"domain": "jul2", "measure": 170},
                  {"domain": "aug2", "measure": 280},
                  {"domain": "sep2", "measure": 190},
                  {"domain": "okt2", "measure": 100},
                  {"domain": "nov2", "measure": 110},
                  {"domain": "des2", "measure": 120},
                ],
              }
              ]
            ),
          )
        ],
      ),
    );
  }
}
