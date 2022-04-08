import 'package:flipper/constants/const.dart';
import 'package:flipper/logic/cubit/bloc.dart';
import 'package:flipper/logic/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '../widgets/widgets.dart';
import 'dart:math' as math;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppStates>(
      builder: (context, state) {
        var tasks = BlocProvider.of<AppBloc>(context).listTasks;
        var bloc = BlocProvider.of<AppBloc>(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey, Good \n$dayPart !',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'You have added ',
                                style: bodyText1(16, FontWeight.normal,
                                    bloc.isDark ? secondaryColor : greyColor),
                              ),
                              Text(
                                '${tasks.length.toString()} tasks ',
                                style: bodyText1(
                                    14, FontWeight.normal, primaryColor),
                              ),
                              Text(
                                'to your list',
                                style: bodyText1(16, FontWeight.normal,
                                    bloc.isDark ? secondaryColor : greyColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: CircleAvatar(
                          backgroundColor: bloc.isDark == true
                              ? const Color.fromARGB(6, 255, 255, 255)
                              : const Color(0x08000000),
                          radius: 18,
                          child: IconButton(
                            onPressed: () {
                              BlocProvider.of<AppBloc>(context).changeTheme();
                            },
                            icon: Icon(
                              bloc.isDark == true
                                  ? Icons.brightness_5_outlined
                                  : Icons.brightness_2_outlined,
                              size: 20,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (tasks.isEmpty)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset('assets/lottie/empty.json'),
                          const SizedBox(
                            height: 35,
                          ),
                          Text(
                            'Get yourself some tasks',
                            style:
                                bodyText1(16, FontWeight.bold, secondaryColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Anything to add?',
                            style: bodyText1(16, FontWeight.normal,
                                bloc.isDark ? Colors.white10 : greyColor),
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Dismissible(
                          key: Key(tasks[index]['id'].toString()),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            BlocProvider.of<AppBloc>(context)
                                .deleteTask(tasks[index]['id']);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(71, 219, 219, 219),
                                    offset: Offset(0, 5),
                                    blurRadius: 10.0,
                                    // spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: RoundCheckBox(
                                  checkedColor: primaryColor,
                                  borderColor: bloc.isDark == true
                                      ? Colors.white
                                      : primaryColor,
                                  size: 25,
                                  checkedWidget: const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  isChecked: tasks[index]['status']
                                      .toString()
                                      .parseBool(),
                                  onTap: (newVal) {
                                    if (tasks[index]['status'] == 'true') {
                                      BlocProvider.of<AppBloc>(context)
                                          .updateTask(
                                        status: 'false',
                                        id: tasks[index]['id'],
                                      );
                                    } else {
                                      BlocProvider.of<AppBloc>(context)
                                          .updateTask(
                                        status: 'true',
                                        id: tasks[index]['id'],
                                      );
                                    }
                                  },
                                  animationDuration: const Duration(
                                    milliseconds: 250,
                                  ),
                                ),
                                title: Text(
                                  '${tasks[index]['taskName']}',
                                  style: bodyText1(18, FontWeight.bold,
                                      const Color(0xff909090)),
                                ),
                                // trailing: const Icon(
                                //   Icons.menu,
                                //   color: greyColor,
                                // ),
                                // trailing: Icon(
                                //   Icons.flag,
                                //   color: dummy_color[index],
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          floatingActionButton: Container(
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
                BlocProvider.of<AppBloc>(context).getData;
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Add a new task',
                style: bodyText1(14, FontWeight.bold, Colors.white),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

extension BoolParsing on String {
  bool parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean.';
  }
}
