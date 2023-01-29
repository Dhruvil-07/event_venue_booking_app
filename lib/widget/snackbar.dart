import 'package:flutter/material.dart';


ScaffoldFeatureController showsnakbar(BuildContext context , String cnt , Color bcolor , Color tcolor){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: bcolor,
          elevation: 30.0,
          // padding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 40.0),
          margin: EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
          shape: StadiumBorder(),
          duration: Duration(seconds:3),
          behavior: SnackBarBehavior.floating,
          content: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cnt,
                    style: TextStyle(
                      color: tcolor,
                    ),
                  ),
                ],
              )
          )
      )
  );
}

