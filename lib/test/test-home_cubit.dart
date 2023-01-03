import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/cubit/test-home_state.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitialState());
  static HomeCubit get(context)=>BlocProvider.of(context);

  var humiReading ;
  var tempReading ;
  final dataBase = FirebaseDatabase.instance.ref();

  void listenChanges(){
    emit(GettingDataLoadingState());
    dataBase.child('Sensor/').once().then((snap) {
      humiReading = snap.snapshot.value;
      tempReading = snap.snapshot.value;
      // ledOn = snap.snapshot.value == 1;
    }).catchError((snapError){

    }).then((value) {

      emit(GettingDataSuccessState());
    }).catchError((generalError){
      emit(GettingDataErrorState());
    });
    dataBase.child('Sensor').onChildChanged.listen((event) {
      DataSnapshot snap = event.snapshot;
      if (snap.key == 'Humidity_data') {
        humiReading = snap.value;
      }
      if (snap.key == 'Temperature_data') {
        tempReading = snap.value;
      }
      emit(ListeningDataSuccessState());
    });

  }
  bool ledOn = false;
  void ledChange(){
    emit(LedPressed());
    ledOn =!ledOn;
    final child =dataBase.child('Sensor/');
    int ledInt= ledOn ? 1:0;
    child.update({'Led':ledInt});
    emit(LedChanged());
  }
  bool cradle = false;
  void moveCradle(){
    emit(CradlePressed());
    cradle =!cradle;
    final child =dataBase.child('Sensor/');
    int ledInt= cradle ? 1:0;
    child.update({'Cradle':ledInt});
    emit(CradlePressed());
  }
  bool fan = false;
  void openFan(){
    emit(FanPressed());
    fan =!fan;
    final child =dataBase.child('Sensor/');
    int ledInt= fan ? 1:0;
    child.update({'Fan':ledInt});
    emit(FanPressed());
  }

  bool toys = false;
  void openToys(){
    emit(ToysPressed());
    toys =!toys;
    final child =dataBase.child('Sensor/');
    int ledInt= toys ? 1:0;
    child.update({'Toys':ledInt});
    emit(ToysPressed());
  }

}