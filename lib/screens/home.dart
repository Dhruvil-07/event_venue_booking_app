import 'package:admin/authentication/signinauth.dart';
import 'package:admin/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/button.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Home Screen",
        ),
      ),

      body: Container(
        alignment: Alignment.center,
                child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children:
          [

            button(onpress: () async
            {
              final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              await sharedPreferences.remove('loginuser')
              .whenComplete((){
                Navigator.push(context , MaterialPageRoute(builder: (context)=>loginsscreen()));
              });
            },
            btncolor: Colors.black , txtcolor: Colors.cyan , height: 50.0 , widtht: 200.0 , btnval: 'logout'),



            button(onpress: () async
            {
              logout()
                  .whenComplete((){ Navigator.push(context, MaterialPageRoute(builder: (context)=>loginsscreen())); });
            },
                btncolor: Colors.black , txtcolor: Colors.cyan , height: 50.0 , widtht: 200.0 , btnval: 'delete account'),
          ],

        ),
      ),
    );
  }
}
