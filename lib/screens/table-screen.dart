import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_baby_cradle/home-layout/home-cubit.dart';
import 'package:smart_baby_cradle/home-layout/home-states.dart';


class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getJson(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, HomeStates state) {},
        builder: (BuildContext context, HomeStates state) {
          HomeCubit cubit = BlocProvider.of(context);
          return Scaffold(
            body: state is JsonGettingState
                ? Container(
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
            )
                : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFFfce2e1), Colors.white]), //لون الخلفية
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: cubit.itemCount,
                  itemBuilder: (context, index) {
                    return readingBuilder(cubit, index - 1, context);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget readingBuilder(HomeCubit cubit, int index, context) {
    Map<String, dynamic>? row;
    List<String>? dates;
    if (index != -1) {
      row = cubit.values![index];
      dates = row!['date'].split('T');
    }
    return index == -1
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Date',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          height: 20.0,
          width: 1.0,
          color: Colors.grey,
          margin: const EdgeInsets.only(
            left: 10.0,
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Time',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          height: 20.0,
          width: 1.0,
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Temperature',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          height: 20.0,
          width: 1.0,
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Humidity',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              dates![0],
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              maxLines: 1,
            ),
          ),
        ),
        Container(
          height: 20.0,
          width: 1.0,
          color: Colors.grey,
          margin: const EdgeInsets.only(
            left: 10.0,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              dates[1].substring(0, 8),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Container(
          height: 20.0,
          width: 1.0,
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        Expanded(
          child: Center(
            child: Text(
              '${row!['tvalue']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Container(
          height: 20.0,
          width: 1.0,
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        Expanded(
          child: Center(
            child: Text(
              '${row['hvalue']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }
}
