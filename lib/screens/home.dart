import 'dart:async';
import 'package:admin/authentication/signinauth.dart';
import 'package:admin/screens/drawer.dart';
import 'package:admin/screens/login.dart';
import 'package:admin/screens/navbar.dart';
import 'package:admin/screens/phoneauth.dart';
import 'package:admin/screens/state.dart';
import 'package:admin/screens/temp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/button.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  Stream<QuerySnapshot> venues = FirebaseFirestore.instance.collection('venue').snapshots();
  bool isloading = true;

  List categaries = ["Festivity" , "Sport" , "Party" , "Wedding" , "Convention Hall" , "Exhibition"];
  List cpic =
  [
    "https://img.jakpost.net/c/2019/01/01/2019_01_01_61938_1546306089._large.jpg",
    "https://t3.ftcdn.net/jpg/02/78/42/76/360_F_278427683_zeS9ihPAO61QhHqdU1fOaPk2UClfgPcW.jpg",
    "https://media.istockphoto.com/id/1324006497/photo/music-controller-dj-mixer-in-a-nightclub-at-a-party.jpg?b=1&s=170667a&w=0&k=20&c=8UWTZesYCiRUZVC-QSv-6Q4VFh78mSIQQmkQY3aa_tM=",
    "https://cdn0.weddingwire.in/vendor/2965/3_2/960/jpg/wedding-venue-palkhi-banquets-lawns-mandap-decor-3_15_202965-160587132182586.webp",
    "https://cdn0.weddingwire.in/vendor/4804/3_2/960/jpg/22788781-378528609269289-5021866473196641006-n_15_134804.jpeg",
    "https://news.artnet.com/app/news-upload/2019/09/installation-srgm-hilma-2480x1396.jpg",
  ];

  User? user = FirebaseAuth.instance.currentUser;

  void initState()
  {
    super.initState();
    Timer(Duration(seconds: 2) ,(){
    setState(() {
    isloading = false;
    });
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      drawer: navbar(),
      appBar:AppBar (
        elevation: 0.0,
        backgroundColor: Colors.deepPurple.withOpacity(0.5),
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text("Home" ,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          ),
        ),
      ),

      body: isloading ?

      Center(
          child: Container(
              height: 100.0,
              child: Lottie.network("https://assets9.lottiefiles.com/private_files/lf30_ixykrp0i.json")
          )
      )

      :
      SingleChildScrollView(

        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.deepPurple.withOpacity(0.3),
           child: Stack(

            children: [

              //TOP DESIGN //
              Padding(
                padding: const EdgeInsets.only(top: 20.0 , left: 10.0 , right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ Colors.white , Colors.deepPurple.withOpacity(0.4) ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only( bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0) , topRight: Radius.circular(40.0),
                    ),
                  ),
                  height: 300.0,
                  child: Column(
                    children: [


                      /*// ICON BUTTON DESIGN //
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only( top: 60.0 , left: 20.0),
                            child: IconButton(onPressed: (){ navbar(); }, icon: Icon(Icons.menu , size: 30.0,)),
                          ),

                          Padding(
                            padding: const EdgeInsets.only( top: 40.0 , left: 260.0),
                            child: IconButton(onPressed: (){}, icon: Icon(Icons.notifications  , size: 30.0,)),
                          ),
                        ],
                      ),
                      // ICONS BUTTON DESIGN END //
*/


                      SizedBox( height: 50.0,),


                      // NAME  ROW//
                      Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 23.0 , top: 10.0),
                            child: Text("Welcome \n       ${user!.displayName}" ,
                              style: GoogleFonts.aclonica(
                                fontSize: 30.0,
                              ),

                              /* TextStyle(
                                fontSize: 30,
                                fontFamily: GoogleFonts.lato,
                              ),*/
                            ),
                          ),
                        ],
                      ),
                      //NAME ROW END//


                      SizedBox( height: 20.0,),


                      //SLOGN ROW//
                      Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 23.0 , top: 20.0),
                            child: Text("Your Event Is Our \n                 First Priority" ,
                              style:GoogleFonts.notoSerif(
                                fontSize: 25.0,
                              ),

                              /*TextStyle(
                                fontSize: 30,
                                fontFamily: "dancingfont",
                               // fontFamily: GoogleFonts.damion()
                              ),*/
                            ),
                          ),
                        ],
                      ),
                      //SLOGN ROW END//

                    ],
                  ),
                ),
              ),
              //TOP DESIGN END//


              SizedBox( height: 0.0,),


              Padding(
                padding: const EdgeInsets.only( top: 370.0 , left: 10.0),
                child: Container(
                  height: 35.0,
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),


              SizedBox( height: 100.0,),
              
              // CATEGORIS DESIGN //
              Padding(
                padding: const EdgeInsets.only( top: 420.0 , left: 10.0),
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                      itemCount: categaries.length,
                      itemBuilder:(BuildContext context , int index)
                          {
                            return Stack(
                              children: [

                                InkWell(
                                  child: Card(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      color: Colors.white.withOpacity(0.3),
                                      height: 300.0,
                                      width: 400.0,
                                      padding: EdgeInsets.all(10.0),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5.0 , bottom: 70.0, ),
                                        width: 400.0,
                                        height: 300.0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.network("${cpic[index]}",
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: EdgeInsets.all(10.0),
                                    color: Colors.grey[200],
                                    shadowColor: Colors.grey[900],
                                    borderOnForeground: true,
                                  ),
                                  onTap:(){ Get.to(state(type: categaries[index]));},
                                ),


                                Positioned(
                                  bottom: 25,

                                  child: Container(
                                      width: 300,
                                      padding: const EdgeInsets.only(left: 100.0, bottom: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Center(
                                            child: Text("${categaries[index]}" ,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),

                              ],
                            );



                          }
                  ),
                ),

              ),
              // CATEGORIS DEIGN END//



            ],
          ),
        ),
      )
    );
  }
}



//

/*

 StreamBuilder<QuerySnapshot>
        (
        stream: venues,
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot)
        {

          List venuedtl = [];
          List filterlist = [];

          snapshot.data!.docs.map((DocumentSnapshot document)
          {
            Map a = document.data() as Map<String,dynamic>;
            venuedtl.add(a);

            venuedtl.forEach((element)
            {
              if( element['City'] == "Church Gate")
              {

                String et = element["Types"].toString();
                // len = et.length;
               if( et.contains("Sport"))
                 {
                   filterlist.add(element);
                 }


                 /*for(int i = 0 ; i<len ; i++)
                   {
                     var eventtype = element['Types'][i];
                     if(eventtype == type[0])
                       {
                         print("true");

                         break;
                       }

                   }*/

              }
            });

            print(filterlist);
          } ).toList();

          return Container(
            child: ListView.builder(
                itemCount: filterlist.length,
                itemBuilder: (context , index)
                {
                  return ListTile(
                    title: Text("${filterlist[index]['City']}"),
                    subtitle: Text("${filterlist[index]['Types']}"),
                  );
                }
            ),
          );
        },
      ),

*/






/*
 //TOP DESIGN //
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8),
                  borderRadius: BorderRadius.only( bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0),
                  ),
              ),
                height: 350.0,
                child: Column(
                  children: [


                    // ICON BUTTON DESIGN //
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only( top: 60.0 , left: 20.0),
                          child: IconButton(onPressed: (){ ZoomDrawer.of(context)?.toggle();  }, icon: Icon(Icons.menu , size: 30.0,)),
                        ),

                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 260.0),
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.notifications  , size: 30.0,)),
                        ),
                      ],
                    ),
                    // ICONS BUTTON DESIGN END //



                    SizedBox( height: 20.0,),




                    // NAME  ROW//
                    Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 23.0 , top: 20.0),
                          child: Text("Welcome Dhruvil" ,
                           style: TextStyle(
                             fontSize: 25,
                           ),
                          ),
                        ),
                      ],
                    ),
                    //NAME ROW END//


                    SizedBox( height: 20.0,),


                    //SLOGN ROW//
                    Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 23.0 , top: 20.0),
                          child: Text("Your Event Is  \nOur First Priority" ,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  //SLOGN ROW END//

                  ],
                ),
              ),
             //TOP DESIGN END//

 */