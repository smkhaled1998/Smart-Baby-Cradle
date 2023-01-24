import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/home-layout/home-states.dart';

import 'package:smart_baby_cradle/screens/control-cradle-screen.dart';
import 'package:smart_baby_cradle/screens/line-chart.dart';

import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

import 'package:http/http.dart' as http;
import 'package:smart_baby_cradle/main.dart';
import 'package:smart_baby_cradle/screens/table-screen.dart';
import 'package:smart_baby_cradle/shared/components.dart';
import 'package:smart_baby_cradle/shared/notification.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  ///*************Layout*******************
  List<Widget> screen = [
    const ControlCradleScreen(),
    const LineChartScreen(),
    const TableScreen(),
  ];
  int currentIndex = 0;

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  ///*****************Common**************************/
  final dataBase = FirebaseDatabase.instance.ref();

  ///****************GetJson***********************/
    String? json;
    int itemCount = 60;
    List<dynamic>? values ;
    List<double> tData = [];//dynamic
    List<double> hData = [];//dynamic
    List<String> time = [];

  Future getJson() async {
    emit(JsonGettingState());
    var url = Uri.parse(
        "https://script.google.com/macros/s/AKfycbzVNPB_NkdaIKmDZnBtDgkRYTMzWoS9qgZEG9O7wE79H_HyU2svWuR3nGPiQJAl_G5h/exec");
      json = await http.read(url).then((value) {
      values = jsonDecode(value);
      //  print(values);
      itemCount = values!.length < 60 ? values!.length : 60;
      var dataUsed = values!.sublist(0, itemCount);
      tData = [];
      hData = [];
      time = [];

      for (var element in dataUsed) {
        tData.add(( element['tvalue'].toDouble())/100);
        hData.add((element['hvalue'].toDouble())/100);
        time.add(element['date'].split('T')[1].substring(0, 5));
      }
       print(tData);
      print(hData);
      print(time);

      emit(JsonGotSuccessState());
      return value;
    }).catchError((error) {
      print('Error is ${error.toString()}');
      emit(JsonGotErrorState());
    });

  }
  ///****************getDataB*****************/
  var hReading;
  var tReading;
  var minutes;
  var soundStatus;

  void getDataB() {
    emit(DataGettingState());
    dataBase.onValue.listen((DatabaseEvent event) async {

      final humidity = await dataBase.child('Sensor/Humidity_data').get();
      final temp = await dataBase.child('Sensor/Temperature_data').get();
      final minutesSnap = await dataBase.child('Sensor/clock').get();

      hReading = humidity.value;
      tReading = temp.value;
      minutes = minutesSnap.value;

      emit(DataGotSuccessState());
      getJson();
    });
    dataBase.child('Sensor').onChildChanged.listen((event) {
      DataSnapshot snap = event.snapshot;
      DataSnapshot snap1 = event.snapshot;
      if (snap.key == 'Humidity_data'&&snap1.key == 'Temperature_data') {
        hReading = snap.value;
        tReading = snap1.value;
        emit(DataGotSuccessState());
      }
    });
  }


  ///***************Sound*********************/
  void getSound() {
    dataBase.onValue.listen((event) async {
      final sound = await dataBase.child('notification/status').get();
      final fan = await dataBase.child('notification/fanstatus').get();
      var soundStatus = sound.value.toString();
      var fanStatus = fan.value.toString();
      if (soundStatus == "1") {
        Noti.showBigTextNotification(
            title: "Sound is detected: ",
            body: "Baby is Crying ",
            fln: flutterLocalNotificationsPlugin);
        showToast(text: "Baby is Crying", state: ToastStates.SUCCESS);
        final child = dataBase.child('notification/');
        int spot = 0;
        child.update({'status': spot});
      }
      if (fanStatus == "1") {
        Noti.showBigTextNotification(
            title: "weather Condition: ",
            body: "Humidity is high ",
            fln: flutterLocalNotificationsPlugin);
        showToast(text: "Humidity is high", state: ToastStates.SUCCESS);
        final child = dataBase.child('notification/');
        int spot = 0;
        child.update({'fanstatus': spot});
      }
      emit(SoundStatusSuccessState());
    });
  }

  /// ***************************************/
  bool isActiveSpot = false;

  void activeSpot() {
    isActiveSpot = !isActiveSpot;
    final child = dataBase.child('Sensor/');
    int spot = isActiveSpot ? 1 : 0;
    child.update({'Led': spot});
    emit(SpotSuccessState());
  }

  bool isActiveCradle = false;

  void activeCradle() {
    isActiveCradle = !isActiveCradle;
    final child = dataBase.child('Sensor/');
    int cradle = isActiveCradle ? 1 : 0;
    child.update({'Cradle': cradle});
    emit(CradleSuccessState());
  }

  bool isActiveFan = false;

  void activeFan() {
    isActiveFan = !isActiveFan;
    final child = dataBase.child('Sensor/');
    int fan = isActiveFan ? 1 : 0;
    child.update({'Fan': fan});
    emit(FanSuccessState());
  }

  bool isActiveToys = false;

  void activeToys() {
    isActiveToys = !isActiveToys;
    final child = dataBase.child('Sensor/');
    int toys = isActiveToys ? 1 : 0;
    child.update({'Toys': toys});
    emit(ToysSuccessState());
  }
}
