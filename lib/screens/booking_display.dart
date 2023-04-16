import 'package:admin/screens/booking.dart';
import 'package:admin/screens/confirm_booking.dart';
import 'package:admin/screens/home.dart';
import 'package:admin/screens/pending_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class bookingdisplay extends StatefulWidget {
  const bookingdisplay({Key? key}) : super(key: key);

  @override
  State<bookingdisplay> createState() => _bookingdisplayState();
}

class _bookingdisplayState extends State<bookingdisplay> {

  Stream<QuerySnapshot> venues = FirebaseFirestore.instance.collection('venue').snapshots();



  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(

       /* appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0.1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: (){ ZoomDrawer.of(context)?.toggle();  }, icon: Icon(Icons.menu , size: 30.0,)),

              SizedBox(width: 30.0,),

              Text("Booking Display Window" ,
              ),
            ],
          ),
        ),*/

        body: Container(
          color: Colors.deepPurple.withOpacity(0.3),
          child: Column(
                  children: [

                    SizedBox(height: 50.0,),

                    //tile detail //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){ ZoomDrawer.of(context)?.toggle();  }, icon: Icon(Icons.menu , size: 30.0,)),

                        SizedBox(width: 30.0,),

                        Text("Booking Display Window",
                          style: GoogleFonts.oswald(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                    ),
                    //over//

                    SizedBox(height: 30.0,),

                    // custom tab bar start //
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(width: 2.0 , color: Colors.black),
                          ),
                          height: 50,
                          child: TabBar(
                            indicator: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.white,
                            tabs: [
                              Text("Pending Booking",
                              style: GoogleFonts.alegreya(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                //color: Colors.black,
                              ),
                              ),

                              Text("Confirm Boking",
                                style: GoogleFonts.alegreya(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  //color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                   ),
                 // Cutom Tab Bar over //

                    SizedBox(height: 10.0,),

                    Expanded(
                        child: TabBarView(
                      children: [

                        pendingbooking(),
                        confirmbooking(),

                      ],
                    ))

                     ],
                ),
        ),

      ),
    );
  }
}
