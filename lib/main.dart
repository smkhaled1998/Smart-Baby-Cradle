
import 'package:smart_baby_cradle/cradle-control-page/device_cubit.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_states.dart';
import 'package:smart_baby_cradle/cradle-control-page/devices.dart';
import 'package:smart_baby_cradle/shared/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>DeviceCubit()..getSound(),
      child: BlocConsumer<DeviceCubit,DeviceStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Devices(),
          );
        },
      ),
    );
  }


}

