import 'dart:async';
import 'dart:ui';

import 'package:admin/screens/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  void initState()
  {
    Timer(Duration(seconds: 5), () {Navigator.push(context, MaterialPageRoute(builder: (context)=>loginsscreen()));});
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
  }
}



