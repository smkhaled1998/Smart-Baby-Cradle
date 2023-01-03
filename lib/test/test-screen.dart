import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/cubit/test-home_cubit.dart';
import 'package:smart_baby_cradle/cubit/test-home_cubit.dart';
import 'package:smart_baby_cradle/cubit/test-home_state.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> HomeCubit()..listenChanges(),
      child: BlocConsumer< HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.home),
              title: const Text('Smart Car'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Control Your Devices',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              padding:
                              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                cubit.ledOn ? Colors.red : Colors.green,
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: cubit.ledOn ? Colors.red : Colors.green)))),
                          onPressed: () {
                            cubit.ledChange();
                            print ("Changed");
                          },
                          child: Text(
                            cubit.ledOn ? "Led OFF" : "LED on",
                            style: const TextStyle(fontSize: 25),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                          style: ButtonStyle(
                              padding:
                              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                cubit.cradle ? Colors.red : Colors.green,
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: cubit.cradle ? Colors.red : Colors.green)))),
                          onPressed: () {
                            cubit.moveCradle();
                          },
                          child: Text(
                            cubit.cradle ? "Cradle OFF" : "Cradle on",
                            style: const TextStyle(fontSize: 25),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              padding:
                              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                cubit.fan ? Colors.red : Colors.green,
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: cubit.fan ? Colors.red : Colors.green)))),
                          onPressed: () {
                            cubit.openFan();
                          },
                          child: Text(
                            cubit.fan ? "Fan OFF" : "Fan on",
                            style: const TextStyle(fontSize: 25),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                          style: ButtonStyle(
                              padding:
                              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                cubit.toys ? Colors.red : Colors.green,
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: cubit.toys ? Colors.red : Colors.green)))),
                          onPressed: () {
                            cubit.openToys();
                          },
                          child: Text(
                            cubit.toys ? "toys OFF" : "toys on",
                            style: const TextStyle(fontSize: 25),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'the Humidity Data is',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${cubit.humiReading}',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'the Temp Data is',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${cubit.tempReading}',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),

                ],
              ),
            ),
          );
        },

      ),
    );
  }
}

