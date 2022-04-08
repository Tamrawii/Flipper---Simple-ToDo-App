import 'package:flipper/logic/cubit/bloc.dart';
import 'package:flipper/logic/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../constants/const.dart';


String get dayPart {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk').format(now);
  if (int.parse(formattedDate) >= 5 && int.parse(formattedDate) <= 11) {
    return 'Morning';
  } else if (int.parse(formattedDate) >= 12 && int.parse(formattedDate) <= 17) {
    return "Afternoon";
  } else if (int.parse(formattedDate) >= 18 && int.parse(formattedDate) <= 21) {
    return "Evening";
  } else {
    return 'night';
  }
}


Widget noTasks() => Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/lottie/empty.json'),
          const SizedBox(
            height: 35,
          ),
          Text(
            'Get yourself some tasks',
            style: bodyText1(16, FontWeight.bold, secondaryColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Anything to add?',
            style: bodyText1(16, FontWeight.normal, greyColor),
          ),
        ],
      ),
    );

Widget floatingBtn(context) => Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.5),
            offset: const Offset(0, 5),
            blurRadius: 20.0,
            // spreadRadius: 1.0,
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/n');
        },
        icon: const Icon(Icons.add),
        label: Text(
          'Add a new task',
          style: bodyText1(14, FontWeight.bold, Colors.white),
        ),
      ),
    );

PreferredSizeWidget appBar(context) => AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: secondaryColor,
        ),
      ),
      title: Text(
        'My Task',
        style: bodyText1(20, FontWeight.bold, secondaryColor),
      ),
      centerTitle: true,
      actions: [
        BlocBuilder<AppBloc, AppStates>(
          builder: (context, state) {
            return IconButton(
              onPressed: () => context.watch<AppBloc>().insertDB(),
              icon: const Icon(
                Icons.add_circle_rounded,
                color: secondaryColor,
              ),
            );
          },
        )
      ],
    );




