import 'package:admin/screens/drawer.dart';
import 'package:admin/screens/forgetpwd.dart';
import 'package:admin/screens/home.dart';
import 'package:admin/screens/login.dart';
import 'package:admin/screens/phoneauth.dart';
import 'package:admin/screens/signup.dart';
import 'package:admin/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home : splashscreen(),
      routes:
      {
        '/splashscreeen' : (context) => splashscreen(),
        '/login' : (context) => loginsscreen(),
        '/signup' : (context) => signup(),
        '/forgetpassword' : (context) => forgetpwd(),
        '/phoneauth' : (context) => phoneauth(),
        '/home' : (context) => home(),
        '/drawer' : (context) => drawer(),
      },
    );
  }
}

