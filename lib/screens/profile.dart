import 'package:admin/screens/booking.dart';
import 'package:admin/screens/booking_display.dart';
import 'package:admin/screens/phoneauth.dart';
import 'package:admin/screens/profilepic.dart';
import 'package:admin/screens/updatephoneno.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/signinauth.dart';
import '../model/loginmodel.dart';

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {


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

  //delete method//
  Future<void> deleteuser()
  {
    return FirebaseFirestore.instance.collection('user')
        .doc(user!.uid)
        .delete()
        .then((value) => logout())
        .whenComplete(() => Navigator.pushReplacementNamed(context,"/login") );
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
        height: MediaQuery.of(context).size.height,
        color: Colors.deepPurple.withOpacity(0.1),
        child: Column(
          children: [

            //UPSIDE DESIGN//
            Container(
              height: 450.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors : [Colors.white , Colors.deepPurple.withOpacity(0.5)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.0) , bottomLeft: Radius.circular(50.0)),
              ),

              child: Column(
                children: [

                  //MENU ICON BUTTON//
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0 , left: 10.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){ ZoomDrawer.of(context)?.toggle(); }, icon: Icon(Icons.menu)),

                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(onPressed: ()
                          {
                             showDialog(
                                 context: context,
                                 builder: (context) => AlertDialog(
                                   title: Text("Delete Account"),
                                   content: Text("Are You Sure , You Want To Delete Acount"),
                                   actions: [

                                     TextButton(
                                       onPressed: (){ Navigator.pop(context); },
                                       child: Text("Back"),
                                     ),

                                     TextButton(
                                         onPressed: (){ deleteuser(); },
                                         child: Text("Delete"),
                                     ),


                                   ],
                                 )
                             );
                          }, icon: Icon(Icons.delete) , tooltip: "Delete Account"),

                        ),
                      ],
                    ),
                  ),
                  //MENU ICON BUTTON OVER//



                  //USER NAME DESIGN//
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${loginuser.name}",
                          style: GoogleFonts.alegreya(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ],
                    ),
                  ),
                  //USER NAME DESIGN OVER//


                  //USER PHOTO DESIGN//
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       CircleAvatar(
                         backgroundColor: Colors.white,
                         radius: 100,
                         child: CircleAvatar(
                           radius: 90.0,
                           backgroundImage: NetworkImage("${loginuser.photourl}"),
                           backgroundColor: Colors.black,
                         ),
                       )
                      ],
                    ),
                  ),
                  //USER PHOTO DESIGN OVER//
                  
                  
                  //PIC UPLOAD ICON//
                  Padding(
                    padding: const EdgeInsets.only( top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: (){
                              Navigator.push(context, PageTransition(child: profilepic(), type:  PageTransitionType.topToBottom , duration: Duration(seconds: 1),));
                          },
                          icon: Icon(Icons.camera_alt_rounded , size: 30.0,),
                        ),
                      ],
                    ),
                  )
                  //PIC UPLOAD ICON//


                ],
              ),
            ),
            //UPSISDE DESIGN OVER//


            SizedBox(height: 60.0,),



            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                SizedBox(width: 30.0,),

                Icon(Icons.email ,  size: 30.0, color: Colors.black),

                SizedBox(width: 20.0,),

                Text("${loginuser.email}" ,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),

              ],
            ),

           Padding(
               padding: EdgeInsets.only(top: 10.0),
               child: Divider(height: 5.0, color: Colors.black, thickness: 1.0,)
           ),


            SizedBox(height: 20.0,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left :25.0),
                  child: Icon(Icons.phone,  size: 30.0, color: Colors.black),
                ),

                SizedBox(width: 20.0,),

                Text("${loginuser.phoneno}" ,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),

                SizedBox(width: 140.0,),

                IconButton(onPressed: (){
                  Get.to(phoneupdate());
                }, icon: Icon(Icons.arrow_circle_right , size: 30.0 , color: Colors.black)),

              ],
            ),

            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Divider(height: 5.0, color: Colors.black, thickness: 1.0,)
            ),


            SizedBox(height: 20.0,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left :25.0),
                  child: Icon(Icons.key,  size: 30.0, color: Colors.black),
                ),

                SizedBox(width: 20.0,),

                Text("Change Password" ,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),

                SizedBox(width: 85.0,),

                IconButton(onPressed: (){
                  Get.to(phoneauth());
                  }, icon: Icon(Icons.arrow_circle_right , size: 30.0 , color: Colors.black)),

              ],
            ),

            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Divider(height: 5.0, color: Colors.black, thickness: 1.0,)
            ),



            SizedBox(height: 20.0,),


            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left :15.0),
                  child: IconButton(onPressed: (){

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
                  }, icon: Icon(Icons.arrow_circle_right , size: 30.0 , color: Colors.black)),
                  //Icon(Icons.calendar_month,  size: 30.0, color: Colors.black),
                ),

                SizedBox(width: 20.0,),

                Text("Logout" ,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),

              ],
            ),

            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Divider(height: 5.0, color: Colors.black, thickness: 1.0,)
            ),




          ],
        ),
      ),

    );


  }
}
