import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/home-layout/home-cubit.dart';
import 'package:smart_baby_cradle/home-layout/home-states.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>HomeCubit()..getSound()..getDataB(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=HomeCubit.get(context);
          return Scaffold(
            body: cubit.screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeCurrentIndex(index);
                },
                elevation: 0,
                backgroundColor: Colors.white,
                items:const [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined),label: 'Chart'),
                BottomNavigationBarItem(icon: Icon(Icons.table_chart_outlined),label: 'Table Chart'),
                ]),

          );
        },

      ),
    );
  }
}
