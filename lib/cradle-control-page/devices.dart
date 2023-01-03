import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/svg.dart';

import 'package:smart_baby_cradle/cradle-control-page/device_cubit.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_states.dart';

import 'package:smart_baby_cradle/screens/char-screen.dart';
import 'package:smart_baby_cradle/screens/control-cradle-screen.dart';
import 'package:smart_baby_cradle/screens/line-char.dart';
import 'package:smart_baby_cradle/screens/price-points.dart';
import 'package:smart_baby_cradle/string_to_color.dart';


class Devices extends StatelessWidget {
 List <Widget> screens =[
   const ControlCradleScreen(),
   // Char(),
   CharScreen(),
   // LineChar(pricePoints)
 ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>DeviceCubit()..getJson(),
      child: BlocConsumer<DeviceCubit,DeviceStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=DeviceCubit.get(context);
          return Scaffold(

            body:screens[cubit.currentIndex],
            bottomNavigationBar:
            BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              items:const [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined),label: 'Char'),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
      ),
    );
  }
}

