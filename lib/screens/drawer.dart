import 'package:admin/screens/home.dart';
import 'package:admin/screens/menuscreen.dart';
import 'package:admin/screens/profile.dart';
import 'package:admin/screens/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../model/draweriteam.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() =>  _drawerState();
}

class _drawerState extends State<drawer> {

  MenuIteam currentiteam = MenuIteams.home;

  @override
  Widget build(BuildContext context) {

        return Container(
      width: MediaQuery.of(context).size.width,
      child: ZoomDrawer(
          slideWidth: MediaQuery.of(context).size.width * 0.60,
          mainScreen: getscreen(),
          menuScreen: menuscreen(
            currentiteam: currentiteam,
            onselectediteam: (MenuIteam iteam)
            {
               setState(() {
                 currentiteam = iteam;
               });
            },
          ),
          duration: Duration(seconds: 1),
          angle: 0,
      ),
    );
  }

  getscreen()
 {
      switch(currentiteam)
      {
        case MenuIteams.home :
          return home();
        case MenuIteams.setting :
          return home();
        case MenuIteams.profile :
          return profilepage();
        case MenuIteams.notification:
          return home();
        case MenuIteams.booking :
          return home();
      }
 }

}
