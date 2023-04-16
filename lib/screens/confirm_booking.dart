import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class confirmbooking extends StatefulWidget {
  const confirmbooking({Key? key}) : super(key: key);

  @override
  State<confirmbooking> createState() => _confirmbookingState();
}

class _confirmbookingState extends State<confirmbooking> {

  Stream<QuerySnapshot> cbooking = FirebaseFirestore.instance.collection('cbooking').snapshots();
  User? user = FirebaseAuth.instance.currentUser;
  bool isloading = true;

  void initState()
  {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : StreamBuilder<QuerySnapshot>(
        stream: cbooking ,
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot)
        {

          List cdata = [];
          List filtercdata = [];
          snapshot.data!.docs.map((DocumentSnapshot documentSnapshot){
            Map a = documentSnapshot.data() as Map<String,dynamic>;
            cdata.add(a);
            }).toList();



          cdata.forEach((element)
          {
             if(element["useremail"] == user!.email)
               {
                  filtercdata.add(element);
               }
          });

          print(filtercdata.length);



          return  filtercdata.isEmpty  ?
          Center(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.deepPurple.withOpacity(0.3),
                  child: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_scgyykem.json")
              )
          )


              :

          isloading
              ?
          Center(
          child: Container(
            height: 100.0,
        child: Lottie.network("https://assets9.lottiefiles.com/private_files/lf30_ixykrp0i.json")
        )
        )
               :

          Padding(
            padding: const EdgeInsets.only( top: 0.0 , left: 0.0),
            child: Container(
              color: Colors.deepPurple.withOpacity(0.3),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: filtercdata.length,
                  itemBuilder:(BuildContext context , int index)
                  {

                    Timestamp? startdate = filtercdata[index]["startdate"];
                    DateTime a = startdate!.toDate();
                    String formatestart = DateFormat("dd-MM-yyyy").format(a);

                    Timestamp? enddate = filtercdata[index]["enddate"];
                    DateTime b= enddate!.toDate();
                    String formateend = DateFormat("dd-MM-yyyy").format(b);


                    return Stack(
                      children: [

                        InkWell(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(width: 2.0 , color: Colors.black)
                            ),
                            child: Container(
                              color: Colors.white.withOpacity(0.3),
                              height: 550.0,
                              width: 400.0,
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                margin: EdgeInsets.only(top: 5.0 , bottom: 270.0, ),
                                width: 400.0,
                                height: 300.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: filtercdata[index]["images"] == "" ?
                                  Lottie.network("https://assets9.lottiefiles.com/private_files/lf30_fko1tu3z.json")
                                  :
                                   Image.network("${filtercdata[index]["images"].toString()}",
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
                        ),



                        Positioned(
                          bottom: 20, left: 20.0, right: 20.0,
                          child: Container(
                            height: 250.0, width: 150.0 ,
                            child: Column(
                              children: [

                                // venue name //
                                Row(
                                  children: [

                                    SizedBox(width: 20.0,),


                                    Expanded(
                                      child: SizedBox(
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("Venue" ,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                        ),
                                      ),
                                    ),



                                    Expanded(
                                      child: SizedBox(
                                        width: 200.0,
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("${filtercdata[index]["venuename"]}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                //end venue name //


                                SizedBox(height: 15.0,),


                                // second start //
                                Row(
                                  children: [

                                    SizedBox(width: 20.0,),


                                    Expanded(
                                      child: SizedBox(
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("Landmark" ,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),



                                    Expanded(
                                      child: SizedBox(
                                        width: 200.0,
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("${filtercdata[index]["landmark"]}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                // second over //


                                SizedBox(height: 15.0,),

                                // third strat //
                                Row(
                                  children: [

                                    SizedBox(width: 20.0,),


                                    Expanded(
                                      child: SizedBox(
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("City" ,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),



                                    Expanded(
                                      child: SizedBox(
                                        width: 200.0,
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("${filtercdata[index]["venuecity"]}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                // over //


                                SizedBox(height: 15.0,),

                                // third strat //
                                Row(
                                  children: [

                                    SizedBox(width: 20.0,),


                                    Expanded(
                                      child: SizedBox(
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("State" ,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),



                                    Expanded(
                                      child: SizedBox(
                                        width: 200.0,
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("${filtercdata[index]["venuestate"]}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                // over //




                                SizedBox(height: 15.0,),

                                // third strat //
                                Row(
                                  children: [

                                    SizedBox(width: 20.0,),


                                    Expanded(
                                      child: SizedBox(
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("Start Date" ,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),



                                    Expanded(
                                      child: SizedBox(
                                        width: 200.0,
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("${formatestart}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                // over //



                                SizedBox(height: 15.0,),

                                // third strat //
                                Row(
                                  children: [

                                       SizedBox(width: 20.0,),


                                    Expanded(
                                      child: SizedBox(
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("End Date" ,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),



                                    Expanded(
                                      child: SizedBox(
                                        width: 200.0,
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text("${formateend}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                // over //


                              ],
                            ),
                          ),
                        ),





                      ],
                    );



                  }
              ),
            ),

          );
        },
      ),
    );
  }
}


