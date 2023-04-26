
import 'package:firebase_core/firebase_core.dart';
import 'package:firerest/home-layout/home-layout.dart';
import 'package:firerest/shared/bloc-observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login-file/login-screen.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,

    ));
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent
            )
          )
        ),
        debugShowCheckedModeBanner: false,
      home:  HomeLayout());
  }
}
