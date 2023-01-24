import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/home-layout/home-cubit.dart';
import 'package:smart_baby_cradle/home-layout/home-states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class LineChartScreen extends StatelessWidget {
  const LineChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit()..getJson(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit =HomeCubit.get(context);
          return ConditionalBuilder(
            condition: state is JsonGettingState,
            builder: (ctx)=>  Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFFfce2e1), Colors.white]), //لون الخلفية
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            ),
            fallback:(ctx)=>  Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFFfce2e1), Colors.white]), //لون الخلفية
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text(
                          "Sensor reading Graphs",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: LineGraph(
                            features: [
                              Feature(
                                title: "Temperature Sensor",
                                data: List.from(cubit.tData.reversed),
                                color: Colors.deepPurpleAccent
                              ),
                            ],
                            size: Size((cubit.tData.length * 70.toDouble()),300),
                            labelX:List.from(cubit.time.reversed),
                            labelY: const ['20', '40', '60', '80', '100'],
                            graphColor: Colors.blue,
                            graphOpacity: 0.1,
                            showDescription: true,

                          ),
                        ),
                        Divider(
                          thickness: 5,
                          color: Colors.black,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: LineGraph(
                            features: [
                              Feature(
                                title: "Humidity Sensor",
                                data: List.from(cubit.hData.reversed),
                                color: Colors.grey
                              ),
                            ],
                            size: Size((cubit.hData.length * 70.toDouble()),300),
                            labelX:List.from(cubit.time.reversed),
                            labelY: const ['20', '40', '60', '80', '100'],
                            graphColor: Colors.blueGrey,
                            graphOpacity: 0.3,
                            showDescription: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ) ,

          );
        },
      ),
    );
  }
}
