import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class Char extends StatelessWidget {
  List <Map<String,dynamic>> dataFlutter=
      [
        {'domain': 0, 'measure': 4.1},
        {'domain': 1, 'measure': 4},
        {'domain': 2, 'measure': 6},
        {'domain': 3, 'measure': 1},
        {'domain': 4, 'measure': 2},
        {'domain': 5, 'measure': 4},
        {'domain': 6, 'measure': 3},
        {'domain': 7, 'measure': 5},
        {'domain': 8, 'measure': 3},
        {'domain': 9, 'measure': 6},
        {'domain': 10, 'measure': 3},
        {'domain': 11, 'measure': 5},
        {'domain': 12, 'measure': 3},
        {'domain': 13, 'measure': 6},
        {'domain': 14, 'measure': 3},
        {'domain':15, 'measure': 5},
        {'domain': 16, 'measure': 3},
        {'domain': 17, 'measure': 6},
        {'domain': 18, 'measure': 3},
        {'domain': 19, 'measure': 5},
        {'domain': 20, 'measure': 3},
        {'domain': 21, 'measure': 6},
        {'domain': 22, 'measure': 3},
      ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: DChartLine(
              data: [
                {
                  'id': 'Line',
                  'data': dataFlutter.map((e){
                    return {'domain':e["domain"],"measure":e["measure"]};
                  }).toList()
                },
              ],
              includePoints: true,
              includeArea: true,
              lineColor: (lineData, index, id) => Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
