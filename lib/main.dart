import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/home.dart' show Home;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ClouDaily Tasks',
        theme: ThemeData(
          brightness: Brightness.dark,
          // useMaterial3: false,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: Home(),
      ),
    );
  }
}
