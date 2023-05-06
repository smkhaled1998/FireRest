
import 'package:firebase_core/firebase_core.dart';
import 'package:firerest/category-file/category-cubit.dart';
import 'package:firerest/home-layout/home-cubit.dart';
import 'package:firerest/home-layout/home-layout.dart';
import 'package:firerest/items-file/item-cubit.dart';
import 'package:firerest/shared/bloc-observer.dart';
import 'package:firerest/shared/cashe-helper.dart';
import 'package:firerest/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login-file/login-screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
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
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context)=>HomeCubit()),
       BlocProvider(create: (context)=>ItemsCubit()),
       BlocProvider(create: (context)=>CategoryCubit()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent
              )
            )
          ),
          debugShowCheckedModeBanner: false,
        home:  HomeLayout()),
    );
  }
}
