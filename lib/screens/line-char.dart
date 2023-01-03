import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_cubit.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_states.dart';
import 'package:smart_baby_cradle/screens/price-points.dart';

class LineChar extends StatelessWidget {
  final List<PricePoint> points;
  const LineChar(this.points,{ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeviceCubit,DeviceStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =DeviceCubit.get(context);
        return SafeArea(
          child: AspectRatio(
            aspectRatio: 2,
            child: LineChart(
                LineChartData(lineBarsData: [
                  LineChartBarData(
                      spots:
                      // [ points.map((point) => FlSpot(point.x, point.y)).toList()
                      //   // FlSpot((cubit.time).toList, (cubit.tData)as double)
                      //
                      // ],
                       points.map((point) => FlSpot(point.x, point.y)).toList(),
                      isCurved: false,
                      dotData: FlDotData(show: true)
                  )
                ])
            ),
          ),
        );
      },

    );
  }
}
