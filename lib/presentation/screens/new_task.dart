import 'package:flipper/constants/const.dart';
import 'package:flipper/logic/cubit/bloc.dart';
import 'package:flipper/logic/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppStates>(
      listener: (context, state) {
        if (state is AddTaskState) {
          Navigator.of(context).pop();
          BlocProvider.of<AppBloc>(context).controller.text = '';
          BlocProvider.of<AppBloc>(context).countLength = 0;
        }
      },
      child: BlocBuilder<AppBloc, AppStates>(
        builder: (context, state) {
          var bloc = BlocProvider.of<AppBloc>(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: bloc.isDark == true ? darkColor : Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: bloc.isDark == true ? Colors.white : secondaryColor,
                ),
              ),
              title: Text(
                'My Task',
                style: bodyText1(20, FontWeight.bold,
                    bloc.isDark == true ? Colors.white : secondaryColor),
              ),
              centerTitle: true,
              actions: [
                BlocBuilder<AppBloc, AppStates>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        if (BlocProvider.of<AppBloc>(context)
                            .controller
                            .text
                            .isNotEmpty) {
                          BlocProvider.of<AppBloc>(context).insertDB();
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color:
                            bloc.isDark == true ? Colors.white : secondaryColor,
                      ),
                    );
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AppBloc, AppStates>(
                    builder: (context, state) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          // IconButton(
                          //     onPressed: () {}, icon: const Icon(Icons.flag)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 1, 30, 0),
                            child: TextFormField(
                                onChanged:
                                    BlocProvider.of<AppBloc>(context).countStr,
                                controller: BlocProvider.of<AppBloc>(context)
                                    .controller,
                                cursorColor: bloc.isDark == true
                                    ? Colors.white
                                    : secondaryColor,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: 'Type anything you wan to do',
                                  hintStyle: bodyText1(
                                      18,
                                      FontWeight.bold,
                                      bloc.isDark == true
                                          ? Colors.white12
                                          : greyColor),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                style: bodyText1(
                                    18,
                                    FontWeight.bold,
                                    bloc.isDark == true
                                        ? Colors.white
                                        : Colors.black54)),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<AppBloc, AppStates>(
                    builder: (context, state) {
                      return Text(
                        '${BlocProvider.of<AppBloc>(context).countLength} Characters',
                        style: bodyText1(16, FontWeight.normal,
                            secondaryColor.withOpacity(0.5)),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
