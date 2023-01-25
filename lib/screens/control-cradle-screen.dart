import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/home-layout/home-cubit.dart';
import 'package:smart_baby_cradle/home-layout/home-states.dart';

import 'dart:math' as math;


import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
//
import 'package:flutter_svg/svg.dart';

import 'package:smart_baby_cradle/string_to_color.dart';



class ControlCradleScreen extends StatelessWidget {
  const ControlCradleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        var cubit = HomeCubit.get(context);


        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFfce2e1), Colors.white]), //لون الخلفية
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Control Your Baby Cradle",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      CircleAvatar(
                          minRadius: 16,
                          backgroundImage: AssetImage("assets/images/user.webp"))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "A total of 4 devices",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      "Smart Baby Cradle",
                                      style: TextStyle(
                                          height: 1.1,
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey[300],
                                  size: 30,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OpenContainer(
                                              transitionType: ContainerTransitionType.fadeThrough,
                                              transitionDuration: const Duration(milliseconds: 600),
                                              closedElevation: 4,
                                              openElevation: 0,
                                              openShape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              closedShape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              openBuilder: (BuildContext context, VoidCallback _) {
                                                return Center(child: Text('data'));
                                              },
                                              tappable :  false,
                                              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                                return AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                      width: 0.6,
                                                    ),
                                                    color: cubit.isActiveToys ? "#c207db".toColor() : Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(14.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/svg/baby-mobile-toys-svgrepo-com.svg',
                                                              color:cubit.isActiveToys ? Colors.white : Colors.black,
                                                              height: 30,
                                                            ), // الأيقونة
                                                            const SizedBox(
                                                              height: 14,
                                                            ),
                                                            SizedBox(
                                                              width: 65,
                                                              child: Text(
                                                                'Smart Toys',
                                                                style: TextStyle(
                                                                    height: 1.2,
                                                                    fontSize: 14,
                                                                    color: cubit.isActiveToys ? Colors.white : Colors.black,
                                                                    fontWeight: FontWeight.w500),
                                                              ),
                                                            ),// اسم المربع نفسه
                                                          ],
                                                        ),//المربع كامل
                                                        Transform.scale(
                                                          alignment: Alignment.center,
                                                          scaleY: 0.8,
                                                          scaleX: 0.85,
                                                          child:
                                                          CupertinoSwitch(
                                                            value: cubit.isActiveToys,
                                                            onChanged: (v){
                                                              cubit.activeToys();
                                                            },
                                                            activeColor: cubit.isActiveToys
                                                                ? Colors.white.withOpacity(0.4)
                                                                : Colors.black,
                                                            trackColor: Colors.black,
                                                          ),
                                                        ), // الزرار بتاع القفل والفتح
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),

                                        SizedBox(width: 20,),
                                        Expanded(
                                          child: OpenContainer(
                                              transitionType: ContainerTransitionType.fadeThrough,
                                              transitionDuration: const Duration(milliseconds: 600),
                                              closedElevation: 4,
                                              openElevation: 0,
                                              openShape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              closedShape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              openBuilder: (BuildContext context, VoidCallback _) {
                                                return Center(child: Text('data'));
                                              },
                                              tappable :  false,
                                              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                                return AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                      width: 0.6,
                                                    ),
                                                    color: cubit.isActiveCradle ? "#7739ff".toColor() : Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(14.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/svg/cradle-svgrepo-com.svg',
                                                              color:cubit.isActiveCradle ? Colors.white : Colors.black,
                                                              height: 30,
                                                            ), // الأيقونة
                                                            const SizedBox(
                                                              height: 14,
                                                            ),
                                                            SizedBox(
                                                              width: 65,
                                                              child: Text(
                                                                'Smart Cradle',
                                                                style: TextStyle(
                                                                    height: 1.2,
                                                                    fontSize: 14,
                                                                    color: cubit.isActiveCradle ? Colors.white : Colors.black,
                                                                    fontWeight: FontWeight.w500),
                                                              ),
                                                            ),// اسم المربع نفسه
                                                          ],
                                                        ),//المربع كامل
                                                        Transform.scale(
                                                          alignment: Alignment.center,
                                                          scaleY: 0.8,
                                                          scaleX: 0.85,
                                                          child:
                                                          CupertinoSwitch(
                                                            value: cubit.isActiveCradle,
                                                            onChanged: (v){
                                                              cubit.activeCradle();
                                                            },
                                                            activeColor: cubit.isActiveCradle
                                                                ? Colors.white.withOpacity(0.4)
                                                                : Colors.black,
                                                            trackColor: Colors.black,
                                                          ),
                                                        ), // الزرار بتاع القفل والفتح
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OpenContainer(
                                              transitionType: ContainerTransitionType.fadeThrough,
                                              transitionDuration: const Duration(milliseconds: 600),
                                              closedElevation: 4,
                                              openElevation: 0,
                                              openShape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              closedShape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              openBuilder: (BuildContext context, VoidCallback _) {
                                                return Center(child: Text('data'));
                                              },
                                              tappable :  false,
                                              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                                return AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                      width: 0.6,
                                                    ),
                                                    color: cubit.isActiveFan ? "#c9c306".toColor() : Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(14.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/svg/fan-svgrepo-com.svg',
                                                              color:cubit.isActiveFan ? Colors.white : Colors.black,
                                                              height: 30,
                                                            ), // الأيقونة
                                                            const SizedBox(
                                                              height: 14,
                                                            ),
                                                            SizedBox(
                                                              width: 65,
                                                              child: Text(
                                                                'Smart    Fan   ',
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    height: 1.2,
                                                                    fontSize: 14,
                                                                    color: cubit.isActiveFan ? Colors.white : Colors.black,
                                                                    fontWeight: FontWeight.w500),
                                                              ),
                                                            ),// اسم المربع نفسه
                                                          ],
                                                        ),//المربع كامل
                                                        Transform.scale(
                                                          alignment: Alignment.center,
                                                          scaleY: 0.8,
                                                          scaleX: 0.85,
                                                          child:
                                                          CupertinoSwitch(
                                                            value: cubit.isActiveFan,
                                                            onChanged: (v){
                                                              cubit.activeFan();
                                                            },
                                                            activeColor: cubit.isActiveFan
                                                                ? Colors.white.withOpacity(0.4)
                                                                : Colors.black,
                                                            trackColor: Colors.black,
                                                          ),
                                                        ), // الزرار بتاع القفل والفتح
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        SizedBox(width: 20,),
                                        Expanded(
                                          child: OpenContainer(
                                              transitionType: ContainerTransitionType.fadeThrough,
                                              transitionDuration: const Duration(milliseconds: 600),
                                              closedElevation: 4,
                                              openElevation: 0,
                                              openShape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              closedShape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              openBuilder: (BuildContext context, VoidCallback _) {
                                                return Scaffold(
                                                  appBar: AppBar(
                                                    elevation: 0,
                                                   backgroundColor:Color(0xFFfce2e1) ,
                                                    leading: IconButton(
                                                        onPressed: (){
                                                          Navigator.pop(context);
                                                        },
                                                        icon: Icon(CupertinoIcons.arrow_left,color: Colors.black,)),
                                                    title: Center(child: Text("Sensor Readings",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),)),
                                                  ),
                                                  body: Center(
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.height,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        gradient: LinearGradient(
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: <Color>[
                                                              Colors.white,
                                                              Color(0xFFfce2e1),
                                                              Colors.white,
                                                            ]),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Spacer(),
                                                          Card(
                                                            margin: EdgeInsets.all(15) ,
                                                            shadowColor: Colors.blueGrey,
                                                            child: Container(
                                                              width: double.infinity,
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(height: 10),
                                                                  Text('Temperature Reading',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                                  SizedBox(height: 10,),
                                                                  Container(
                                                                      width:80,
                                                                      height: 80,
                                                                      child: Card(child: Center(child: Text(cubit.tReading.toString(),style: TextStyle(fontWeight: FontWeight.bold),)))),
                                                                  SizedBox(height: 20,)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Card(
                                                            margin: EdgeInsets.all(15) ,
                                                            shadowColor: Colors.blueGrey,
                                                            child: Container(
                                                              width: double.infinity,
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(height: 10),
                                                                  Text('Humidity Reading',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                                  SizedBox(height: 10,),
                                                                  Container(
                                                                      width:80,
                                                                      height: 80,
                                                                      child: Card(child: Center(child: Text(cubit.hReading.toString(),style: TextStyle(fontWeight: FontWeight.bold),)))),
                                                                  SizedBox(height: 20,)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );

                                              },
                                              tappable :  true,
                                              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                                return AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                      width: 0.6,
                                                    ),
                                                    color: cubit.isActiveSpot ? "#ff5f5f".toColor() : Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(14.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/svg/information-help-svgrepo-com.svg',
                                                              color:cubit.isActiveSpot ? Colors.white : Colors.black,
                                                              height: 40,
                                                            ), // الأيقونة
                                                            const SizedBox(
                                                              height: 35,
                                                            ),
                                                            SizedBox(
                                                              width: 65,
                                                              child: Text(
                                                                'Sensor Reading',
                                                                style: TextStyle(
                                                                    height: 1.2,
                                                                    fontSize: 14,
                                                                    color: cubit.isActiveSpot ? Colors.white : Colors.black,
                                                                    fontWeight: FontWeight.w500),
                                                              ),
                                                            ),// اسم المربع نفسه
                                                          ],
                                                        ),//المربع كامل
                                                        // Transform.scale(
                                                        //   alignment: Alignment.center,
                                                        //   scaleY: 0.8,
                                                        //   scaleX: 0.85,
                                                        //   child:
                                                        //   CupertinoSwitch(
                                                        //     value: cubit.isActiveSpot,
                                                        //     onChanged: (v){
                                                        //       cubit.activeSpot();
                                                        //
                                                        //     },
                                                        //     activeColor: cubit.isActiveSpot
                                                        //         ? Colors.white.withOpacity(0.4)
                                                        //         : Colors.black,
                                                        //     trackColor: Colors.black,
                                                        //   ),
                                                        // ), // الزرار بتاع القفل والفتح
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),

                                  ],
                                )

                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );

  }

}
