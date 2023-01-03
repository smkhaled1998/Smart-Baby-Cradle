import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smart_baby_cradle/cradle-control-page/device_cubit.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_states.dart';
import 'package:smart_baby_cradle/main.dart';
import 'package:smart_baby_cradle/screens/price-points.dart';
import 'package:smart_baby_cradle/shared/components.dart';
import 'package:smart_baby_cradle/shared/notification.dart';


class DeviceCubit extends Cubit<DeviceStates> {
  DeviceCubit() : super(DeviceInitialState());

  static DeviceCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomBarState());
  }

  ///****************************************/
  final dataBase = FirebaseDatabase.instance.ref();

  var hReading;
  var tReading;
  var minutes;
  var soundStatus;

  void listenChanges() {
    emit(ListeningChangesDataLoadingState());
    dataBase.onValue.listen((event) async {

      final humidity = await dataBase.child('Sensor/Humidity_data').get();
      final temp = await dataBase.child('Sensor/Temperature_data').get();
      final minutesSnap = await dataBase.child('Sensor/minutes').get();

      hReading = humidity.value;
      tReading = temp.value;
      minutes = minutesSnap.value;

      emit(ListeningChangesDataSuccessState());
      getJson();
    });

    dataBase.child('Sensor').onChildChanged.listen((event) {
      DataSnapshot snap = event.snapshot;
      DataSnapshot snap1 = event.snapshot;
      if (snap.key == 'Humidity_data'&&snap1.key == 'Temperature_data') {
        hReading = snap.value;
        tReading = snap1.value;
       // print(hReading);
      //  print(tReading);
        emit(GettingChangesDataSuccessState());
      }
    });
  }

  ///***************************************

  int itemCount = 60;
  List<dynamic> values = [];
  late String json;

  List<dynamic> tData = [];
  List<dynamic> hData = [];
  List<String> time = [];

  Future getJson() async {
    emit(JsonGettingState());
    var url = Uri.parse("https://script.google.com/macros/s/AKfycbwMREeOesAwh1Y_fIL99MUY_-StN4I-YjElhzmv9z9FUY55MFKspL8qB4Sy_SM1l581/exec");

        json = await http.read(url).then((value) {
        values = jsonDecode(value);
      //  print(values);
      itemCount = values.length < 60 ? values.length : 60;
      var dataUsed = values.sublist(0, itemCount);


      for (var element in dataUsed) {

        tData.add(( element['tvalue'].toDouble())/40 );
        hData.add((element['hvalue'].toDouble())/100);
        time.add(element['date'].split('T')[1].substring(0, 5));
      }
     //  print(tData);
     // print(hData);

      emit(JsonGotSuccessState());
      return value;
    }).catchError((error) {
      print('Error is ${error.toString()}');
      emit(JsonGotErrorState());
    });
  }



  // void listenChanges() {
  //   emit(GettingDataLoadingState());
  //   dataBase.child('Sensor/').once().then((snap) {
  //     sensorReading = snap.snapshot.value;
  //     emit(GettingDataSuccessState());
  //   }).catchError((error){
  //     emit(GettingDataErrorState());
  //   }).then((value) {
  //     // getJson();
  //     emit(GettingDataSuccessState());
  //   }).catchError((error){
  //     emit(GettingDataErrorState());
  //   });
  //
  //   dataBase.child('Sensor').onChildChanged.listen((event) {
  //     DataSnapshot snap = event.snapshot;
  //     if (snap.key == 'Led') {
  //       sensorReading = snap.value;
  //       // emit(ListeningDataSuccessState());
  //     }
  //     emit(ListeningDataSuccessState());
  //   });
  // }

  ///***************Sound*********************/

  void getSound(){
    dataBase.onValue.listen((event) async {
      final sound = await dataBase.child('notification/status').get();
      soundStatus = sound.value.toString();
      if (soundStatus=="1"){
        Noti.showBigTextNotification(title: "Smart Baby Cradle: ", body: "إلحقي ابنك بيعيط ", fln: flutterLocalNotificationsPlugin);
        showToast(text: "Baby is Crying", state: ToastStates.SUCCESS);
        final child = dataBase.child('notification/');
        int spot = 0;
        child.update({'status': spot});
      }
      emit(GetSoundStatusSuccessState());

    });
  }
  /// ***************************************/
  bool isActiveSpot = false;

  void activeSpot() {
    isActiveSpot = !isActiveSpot;
    final child = dataBase.child('Sensor/');
    int spot = isActiveSpot ? 1 : 0;
    child.update({'Led': spot});
    // Noti.showBigTextNotification(title: "Smart Baby Cradle:", body: "Baby is crying", fln: flutterLocalNotificationsPlugin);
    emit(ActiveSpotSuccessState());
  }

  bool isActiveCradle = false;

  void activeCradle() {
    isActiveCradle = !isActiveCradle;
    final child = dataBase.child('Sensor/');
    int cradle = isActiveCradle ? 1 : 0;
    child.update({'Cradle': cradle});
    emit(ActiveCradleSuccessState());
  }

  bool isActiveFan = false;

  void activeFan() {
    isActiveFan = !isActiveFan;
    final child = dataBase.child('Sensor/');
    int fan = isActiveFan ? 1 : 0;
    child.update({'Fan': fan});
    emit(ActiveFanSuccessState());
  }

  bool isActiveToys = false;

  void activeToys() {
    isActiveToys = !isActiveToys;
    final child = dataBase.child('Sensor/');
    int toys = isActiveToys ? 1 : 0;
    child.update({'Toys': toys});
    emit(ActiveToysSuccessState());
  }
}
