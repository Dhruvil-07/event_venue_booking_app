import 'dart:async';
import 'dart:ui';
import 'package:admin/screens/drawer.dart';
import 'package:admin/screens/home.dart';
import 'package:admin/screens/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

String? check;

class _splashscreenState extends State<splashscreen> {


    // PREFRENCES VALUES //
   Future getchecklogin() async
   {
     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var login = sharedPreferences.getString('loginuser');
     setState(() {
       check = login;
     });
     print(check);
   }


  // VALUE GET WHN PAGE LOAD //
  void initState()
  {
    getchecklogin()
    .whenComplete((){
      Timer(Duration(seconds: 5), (){
        check != null ?
        Navigator.pushReplacementNamed(context, "/drawer")
            :
        Navigator.pushReplacementNamed(context, "/login")
        ;
      }
      );
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                child: Lottie.network("https://assets9.lottiefiles.com/packages/lf20_5zptrJ.json"),
              ),
          ],
        ),
      ),


    );
  }}



