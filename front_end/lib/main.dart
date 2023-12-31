import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constants/bloc_observer.dart';
import 'Cubit/cubit.dart';
import 'Cubit/states.dart';
import 'Layouts/main_screen.dart';
import 'network/dio_package.dart';

void main() {
  bool isDark =false;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp( MyApp(isDark: isDark));
}

class MyApp extends StatefulWidget {
  final bool isDark;
  MyApp({
    required this.isDark,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context)=>NoteCubit()..fetchDataFromBackend()
          )
        ],
        child: BlocConsumer<NoteCubit,NoteStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              // theme:lightTheme,
              // darkTheme: darkTheme,
              themeMode: NoteCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: MainScreen(),
            );
          },
        )
    );
  }


}

