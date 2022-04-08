import 'package:flipper/constants/const.dart';
import 'package:flipper/logic/cubit/bloc.dart';
import 'package:flipper/logic/cubit/states.dart';
import 'package:flipper/logic/cubit/storage/shared_preferneces.dart';
import 'package:flipper/presentation/screens/new_task.dart';
import 'package:flipper/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  bool? isDark = SharedPrefs.getValue(key: 'isDark');
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark,}) : super(key: key);
  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => AppBloc()..createDb()..changeTheme(isDark),
      child: BlocBuilder<AppBloc, AppStates>(
        builder: (context, state) {
          var bloc = BlocProvider.of<AppBloc>(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: bloc.isDark == true ? darkColor : Colors.white,
                statusBarIconBrightness:
                    bloc.isDark == true ? Brightness.light : Brightness.dark,
                // statusBarColor: Colors.white,
                // statusBarIconBrightness: Brightness.dark,
              ),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  canvasColor: Colors.white,
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                    backgroundColor: primaryColor,
                    elevation: 0,
                  ),
                  textTheme: const TextTheme(
                    titleLarge: TextStyle(
                      fontFamily: 'Nirmala',
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                      color: secondaryColor,
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  canvasColor: darkColor,
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                    backgroundColor: primaryColor,
                    elevation: 0,
                  ),
                  textTheme: const TextTheme(
                    titleLarge: TextStyle(
                      fontFamily: 'Nirmala',
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                      color: primaryColor,
                    ),
                  ),
                ),
                themeMode:
                    bloc.isDark == false ? ThemeMode.light : ThemeMode.dark,
                routes: {
                  '/': (context) => const SplashScreen(),
                  '/h': (context) => const HomePage(),
                  '/n': (context) => const NewTaskScreen(),
                },
              ));
        },
      ),
    );
  }
}
