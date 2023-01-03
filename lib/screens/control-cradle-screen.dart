import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/svg.dart';

import 'package:smart_baby_cradle/cradle-control-page/device_cubit.dart';
import 'package:smart_baby_cradle/cradle-control-page/device_states.dart';
import 'package:smart_baby_cradle/string_to_color.dart';


class ControlCradleScreen extends StatelessWidget {
  const ControlCradleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeviceCubit,DeviceStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        var cubit = DeviceCubit.get(context);
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
                                                return Center(child: Text('SpotLight'));
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
                                                              'assets/svg/light.svg',
                                                              color:cubit.isActiveSpot ? Colors.white : Colors.black,
                                                              height: 30,
                                                            ), // الأيقونة
                                                            const SizedBox(
                                                              height: 14,
                                                            ),
                                                            SizedBox(
                                                              width: 65,
                                                              child: Text(
                                                                'Smart Spotlight',
                                                                style: TextStyle(
                                                                    height: 1.2,
                                                                    fontSize: 14,
                                                                    color: cubit.isActiveSpot ? Colors.white : Colors.black,
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
                                                            value: cubit.isActiveSpot,
                                                            onChanged: (v){
                                                              cubit.activeSpot();

                                                            },
                                                            activeColor: cubit.isActiveSpot
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
                                      ],
                                    ),



                                  ],
                                )
                              // GridView.builder(
                              //     padding:
                              //     const EdgeInsets.only(top: 10, bottom: 20),
                              //     gridDelegate:
                              //     const SliverGridDelegateWithMaxCrossAxisExtent(
                              //         maxCrossAxisExtent: 200,
                              //         childAspectRatio: 3 / 4,
                              //         crossAxisSpacing: 20,
                              //         mainAxisSpacing: 20),
                              //     itemCount: 2,
                              //     itemBuilder: (BuildContext ctx, index) {
                              //       return Devices(
                              //         name: cubit.devices[index].name,
                              //         svg: cubit.devices[index].icon,
                              //         color: cubit.devices[index].color.toColor(),
                              //         isActive: cubit.devices[index].isActive,
                              //         onChanged: (val) {
                              //           // cubit.toggleSwitch(val);
                              //           if (cubit.devices[index].isActive) {
                              //              !cubit.devices[index].isActive;
                              //           }else {cubit.devices[index].isActive;}
                              //           print(cubit.devices[index].isActive);
                              //         },
                              //       );
                              //     }),
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
