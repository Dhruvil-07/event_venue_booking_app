
import 'package:admin/widget/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/draweriteam.dart';
import '../model/loginmodel.dart';


class MenuIteams
{
    static const home = MenuIteam('Home' , Icons.home);
    static const profile = MenuIteam('Profile' , Icons.person);
    static const booking = MenuIteam('Bokking' , Icons.edit_calendar);
    static const notification = MenuIteam('Notification' , Icons.notification_add);
    static const setting = MenuIteam('setting', Icons.settings);

   static const all = <MenuIteam>[
     home,
     profile,
     booking,
     notification,
     setting,
    ];
}

class menuscreen extends StatefulWidget {

  final MenuIteam currentiteam;
  final ValueChanged<MenuIteam> onselectediteam;

  const menuscreen({Key? key ,  required this.currentiteam , required this.onselectediteam }) : super(key: key);

  @override
  State<menuscreen> createState() => _menuscreenState();
}

class _menuscreenState extends State<menuscreen> {
  //FIREBASE AUTH INSTNACE //
  User? user = FirebaseAuth.instance.currentUser;

  // Login modelcalss object  //
  loginmodel loginuser = loginmodel();

  // User Detail //
  Future<void> userdtl() async
  {
    FirebaseFirestore.instance.collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginuser = loginmodel.frommap(value.data());
      setState(() {
      });
    });
  }

  // Init method for value when page is load //
  void initState()
  {
    userdtl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 2,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:
           /* color: Colors.black,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 2,
            height: MediaQuery.of(context).size.height,*/
            Column(
              children:
              [

                // CIRCLEAVTAR//
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0 , left: 70.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 100,
                        child: CircleAvatar(
                          radius: 95,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage("${loginuser.photourl}"),
                        ),
                      ),
                    ),
                  ],
                ),
                //CIRCLEAVTAR OVER//

                SizedBox(height: 2.0,),

                //NAME OF USER//
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0 , top: 20.0),
                      child: Container(
                        child: Text("${user!.displayName}" , style: GoogleFonts.alegreya(fontSize:25.0 , color: Colors.white),
                          /*TextStyle(color: Colors.white , fontSize: 25.0 , fontFamily: GoogleFonts.alegreya(fontSize: 20.0))*/
                        ),
                      ),
                    ),
                  ],
                ),
                //NAME OF USER OVER//


                SizedBox(height: 40.0,),


                // LIST OF MENU ITEAM//
                ...MenuIteams.all.map(BuildMenuiteams).toList(),
                //LIST OF MENU ITEAM OVER//


                SizedBox(height: 20.0,),


                //LOGOUT BUTTON//
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: button2(
                          onpress: ()async
                          {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Logout"),
                                  content: Text("Are You Sure ??? "),
                                  actions: [

                                    TextButton(
                                        onPressed: (){ Navigator.pop(context); },
                                        child: Text("Back"),
                                    ),

                                    TextButton(
                                      onPressed: () async {
                                       final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                        await sharedPreferences.remove('loginuser').whenComplete(() {Navigator.pushReplacementNamed(context, "/login");});
                                      },
                                      child: Text("Logout")
                                ),
                              ]
                            ),
                          );
                          },
                          txtcolor: Colors.black,
                          btncolor: Colors.white,
                          height: 50.0,
                          widtht: 150.0,
                          icon:Icons.logout,
                          btnval: "LOGOUT",
                          iconcolor: Colors.black
                        ,
                      ),
                    ),
                  ],
                ),
                // LOGOUT BUTTON OVER//


              ],
            ),
        ),
      ),
    );
  }

  Widget BuildMenuiteams(MenuIteam iteam) =>

        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: ListTile(
          minLeadingWidth: 50.0,
          minVerticalPadding: 20.0,
          selected: widget.currentiteam == iteam,
          title: Text("${iteam.title}" , style: GoogleFonts.alegreya(fontSize:25.0 , color: Colors.white),
            /*TextStyle( color: Colors.white ,fontFamily: 'dancingfont' , fontSize: 25.0 , letterSpacing: 1.0 )*/
          ),
          leading: Icon(iteam.icon , color: Colors.white, size: 35.0,),
          onTap: ()=> widget.onselectediteam(iteam),
          ),
        );
}
