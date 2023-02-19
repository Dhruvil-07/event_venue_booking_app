import 'package:admin/screens/phoneauth.dart';
import 'package:admin/screens/profilepic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:page_transition/page_transition.dart';

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
        child: Column(
          children: [

            //UPSIDE DESIGN//
            Container(
              height: 500.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors : [Colors.blue , Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(80.0) , bottomLeft: Radius.circular(80.0)),
                border: Border.all(color: Colors.black , width: 5.0),
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
                            logout()
                                .whenComplete((){ Navigator.pushReplacementNamed(context, "/login"); });
                          }, icon: Icon(Icons.delete) , tooltip: "Delete Account"),

                        ),
                      ],
                    ),
                  ),
                  //MENU ICON BUTTON OVER//



                  //USER NAME DESIGN//
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 120.0,),
                    child: Row(
                      children: [
                        Text("${loginuser.name}",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'dancingfont',
                          ),
                        ),
                      ],
                    ),
                  ),
                  //USER NAME DESIGN OVER//


                  //USER PHOTO DESIGN//
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 115.0,),
                    child: Row(
                      children: [
                       CircleAvatar(
                         radius: 100.0,
                         backgroundImage: NetworkImage("${loginuser.photourl}"),
                         backgroundColor: Colors.black,
                       )
                      ],
                    ),
                  ),
                  //USER PHOTO DESIGN OVER//
                  
                  
                  //PIC UPLOAD ICON//
                  Padding(
                    padding: const EdgeInsets.only( top: 10.0,left: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: (){
                              Navigator.push(context, PageTransition(child: profilepic(), type:  PageTransitionType.topToBottom , duration: Duration(seconds: 2),));
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



            // DOWN SIDE DESIGN//
            Container(
             height: 300.0,
             width: 380.0,

              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue , Colors.white],
                      ),
                    border: Border.all(width: 3.0 , color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: [


                      ListTile(
                        leading: Icon(Icons.email , size: 30.0, color: Colors.black),
                        title: Text("${loginuser.email}" ,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),

                     Divider(height: 7.0, color: Colors.black,),


                      ListTile(
                        leading: Icon(Icons.phone, size: 30.0, color : Colors.black,),
                        title: Text("${loginuser.phoneno}",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_right , size: 30.0 , color: Colors.black),),
                      ),

                      Divider(height: 7.0, color: Colors.black,),



                      ListTile(
                       leading: Icon(Icons.key , size: 30.0, color: Colors.black,),
                       title: Text("Password" ,
                       style: TextStyle(
                         fontSize: 20.0,
                       ),
                       ),
                       trailing: IconButton(onPressed: ()
                       {
                         Navigator.pushReplacement(context, PageTransition(child: phoneauth(), type: PageTransitionType.leftToRight , duration: Duration(seconds: 2)));
                       }, icon: Icon(Icons.arrow_circle_right , size: 30.0 , color: Colors.black,),),
                     ),

                      Divider(height: 7.0, color: Colors.black,),




                      ListTile(
                        leading: Icon(Icons.calendar_month , size: 30.0, color: Colors.black),
                        title: Text("Booking" ,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_right , size: 30.0 , color: Colors.black),),
                      ),

                    ],
                  ),
                ),
              ),
            )
            //DOWN SIDE DESIGN OVER//
          ],
        ),
      ),

    );


  }
}

/*

body: Stack(
children: [

//UPSIDE CONNTAINER DESIGN//
Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.only( bottomLeft: Radius.circular(80.0) , bottomRight: Radius.circular(80.0)),
color: Colors.red,
),
height: 400.0,
),
//UPSIDE COTAINER DESIGN OVER//


//USER NAME POSITION//
Positioned(
top: 100.0,
left: 120.0,
child: Text("USER NAME",
style: TextStyle(
fontSize: 30.0,
fontFamily: 'dancingfont',
),
),
),
//USER NAME POSITION OVER//


//MENU ICON BUTTON//
Positioned(
top: 40.0,
left: 10.0,
child: IconButton(onPressed: (){ ZoomDrawer.of(context)?.toggle(); }, icon: Icon(Icons.menu)),
),
//MENU ICON BUTTON OVER//


Positioned(
top: 180.0,
left: 115.0,
child: CircleAvatar(
backgroundColor: Colors.black,
radius: 100.0,
),
),


],
),

);*/
