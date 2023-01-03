import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_cubit.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_cubit.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_states.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
class CharScreen extends StatelessWidget {
  const CharScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => DeviceCubit()..getJson(),
      child: BlocConsumer<DeviceCubit,DeviceStates>(
        listener: (ctx,state){},
        builder: (ctx,state){
          var cubit =DeviceCubit.get(context);
          return ConditionalBuilder(
            condition:state is! JsonGettingState,
            builder:(ctx)=>Center(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sensor reading Graphs",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: LineGraph(
                          features: [
                            Feature(
                              title: "Humidity Sensor",
                              data: List.from(cubit.hData.reversed),
                              // data: const [10,20,30,40],
                            ),
                          ],
                          size: Size((cubit.hData.length * 70.toDouble()),400),
                          labelX: List.from(cubit.time.reversed),
                          labelY: const ['20', '40', '60', '80', '100'],
                          graphColor: Colors.blue,
                          graphOpacity: 0.1,
                          showDescription: true,
                          verticalFeatureDirection: false,
                          descriptionHeight: 130,

                        ),
                      ),
                      Divider(
                        thickness: 5,
                        color: Colors.black,
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: LineGraph(
                          features: [
                            Feature(
                              title: "Temperature Sensor",
                              color: Colors.green,
                              data: List.from(cubit.tData.reversed),),
                          ],
                          size: Size((cubit.tData.length * 70).toDouble(), 400),
                          labelX: List.from(cubit.time.reversed),
                          labelY: const ['10', '15', '20', '25', '30','35','40'],
                          graphColor: Colors.blue,
                          graphOpacity: 0.1,
                          showDescription: true,
                          verticalFeatureDirection: false,
                          descriptionHeight: 130,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (ctx)=> const Center(child: CircularProgressIndicator()) ,

          );
        },
      ),
    );
  }
}
