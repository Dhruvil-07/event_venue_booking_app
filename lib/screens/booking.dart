import 'dart:ffi';
import 'dart:io';
import 'package:admin/screens/state.dart';
import 'package:admin/screens/venuedisplay.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class booking extends StatefulWidget {

  Map<String,dynamic> venuedata;

  booking({Key? key , required this.venuedata}) : super(key: key);

  @override
  State<booking> createState() => _bookingState();
}

class _bookingState extends State<booking> {

  Stream<QuerySnapshot> bookingdtl = FirebaseFirestore.instance.collection('cbooking').snapshots();

  User? user = FirebaseAuth.instance.currentUser;

  DateTime? datepicker;
  DateTime? selectdate;

  DateTime? start;
  DateTime? end;

  String error = "";

  List days = ["1 day" , "1+ days"];
  String? selectedday = "1 day";

  double? rent;


  //single date bboking//
  Future<void> bookvenue()
  {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('pbooking').doc();
    return documentReference//FirebaseFirestore.instance.collection('pbooking')
        .set({ "username" : user!.displayName.toString() , "useremail" : user!.email.toString(),
               "venueownercontact" : widget.venuedata["DealerContact"] , "venuename" : widget.venuedata["Name"] , "venuedocid" : widget.venuedata["docId"],
               "venuecity" : widget.venuedata["City"] , "venuestate" : widget.venuedata["State"], "venuedocid" : widget.venuedata["docId"],
               "startdate" : selectdate , "enddate" : selectdate , "landmark" :   widget.venuedata["Landmark"], "dealerid" :  widget.venuedata["userId"] , "pendingId" : documentReference.id,
               "images" : widget.venuedata["url0"] ,  "rent" : rent.toString()
        })
        .then((value){ showsnakbar(context, "booking request send succesfully !!!", Colors.cyan, Colors.black); })
        .whenComplete((){Navigator.pop(context);});
  }



  //range date booking //
  Future<void> bookvenuerange()
  {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('pbooking').doc();
    return  documentReference.set({ "username" : user!.displayName.toString() , "useremail" : user!.email.toString(),
      "venueownercontct" : widget.venuedata["DealerContact"] , "venuename" : widget.venuedata["Name"] , "venuedocid" : widget.venuedata["docId"],
      "venuecity" : widget.venuedata["City"] , "venuestate" : widget.venuedata["State"], "venuedocid" : widget.venuedata["docId"],
      "startdate" : start , "enddate" : end , "landmark" :   widget.venuedata["Landmark"], "dealerid" :  widget.venuedata["userId"] , "pendingId" : documentReference.id ,
      "images" : widget.venuedata["url0"] , "rent" : rent.toString()
    })
        .then((value){ showsnakbar(context, "booking request send succesfully !!!", Colors.cyan, Colors.black); })
        .whenComplete((){Navigator.pop(context);});
  }


  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: bookingdtl,
        builder:(BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot)
        {


          // data form comfirm boking//
          List bkdtl = [];
          List filterbkdtl = [];

          snapshot.data!.docs.map((DocumentSnapshot documentSnapshot)
          {
            Map a = documentSnapshot.data() as Map<String,dynamic>;
            bkdtl.add(a);

            bkdtl.forEach((element)
            {
              if(element["venuename"] == widget.venuedata["Name"])
                {
                  filterbkdtl.add(element);
                }
            });

            print(bkdtl);
            print(filterbkdtl);
          }).toList();
          //over//


          return Container(
            color: Colors.deepPurple.withOpacity(0.2),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 50.0,),

                  Text("Booking Window",
                    style: GoogleFonts.oswald(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3.0,
                    ),
                  ),


                  SizedBox(height: 20.0,),

                  Container(
                    height: 280.0,
                    width: 500.0,
                    child: Center(
                      child: Lottie.asset("assets/lottie/booking.json"),

                      //Lottie.network("https://assets7.lottiefiles.com/packages/lf20_xlmz9xwm.json"),
                    ),
                  ),

                  SizedBox(height: 10.0,),

                  //dropdown button //
                  Container(
                    height: 90.0,
                    width: 500.0,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 70.0 , bottom: 10.0 , right: 60.0 , top: 20.0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        hint: Text("select day"),
                        dropdownColor: Colors.green.shade300,
                        value: selectedday,
                        onChanged: (finalstatevalue){
                          setState(() {
                            selectedday = finalstatevalue.toString();
                          });
                        },
                        items: days.map((newstatevalue){
                          return DropdownMenuItem<String>(
                            child: Text(newstatevalue ,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            value: newstatevalue,
                          );
                        },
                        ).toList(),
                      ),
                    ),
                  ),
                  //over//

                  SizedBox(height: 30.0,),


                  Divider(height: 5.0, color: Colors.black,),



                  //date selection//
                  selectedday == "1 day" ?

                  //single day bboking//
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.0,),

                          selectdate == null ?
                          Container(
                            alignment: Alignment.center,
                            width: 200.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2.0 , color: Colors.black),
                            ),
                            child: Text("selected date" ,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            ),
                          )
                              :
                          Container(
                            alignment: Alignment.center,
                            width: 200.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2.0 , color: Colors.black),
                            ),
                            child: Text("${selectdate!.day} / ${selectdate!.month} / ${selectdate!.year}",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ) ,

                          SizedBox(height: 20.0,),

                          IconButton(
                            onPressed: () async
                            {
                              datepicker = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2024),
                              );
                              setState(() {
                                selectdate = datepicker;
                                rent = 0 ;
                                if(selectdate != null)
                                  {
                                    double rentperhour = double.parse(widget.venuedata["RentPerHour"]);
                                    rent = rentperhour * 24;
                                  }

                              });
                            },
                            icon: Icon(Icons.calendar_month , size: 40.0,),
                          ),

                          SizedBox(height: 30.0,),


                          Divider(height: 5.0, color: Colors.black,),

                          SizedBox(height: 50.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Container(
                                alignment: Alignment.center,
                                width:300.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2.0 , color: Colors.black),
                                ),
                                child: Text("Total Rent :  ${rent == null ? "0 ₹" :  "${rent} ₹" }" ,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),

                            ],
                          ),


                          SizedBox(height:30.0,),

                          RaisedButton(
                            shape: StadiumBorder(),
                            color: Colors.black,
                            textColor: Colors.white,
                            onPressed: ()
                            {
                              if(selectdate == null)
                              {
                                showsnakbar(context, "Select date", Colors.cyan, Colors.black);
                              }
                              else if(filterbkdtl.isEmpty)
                              {
                                bookvenue();
                              }
                              else if(filterbkdtl.isNotEmpty) {
                                for (int i = 0; i < filterbkdtl.length; i++) {
                                  error = "";
                                  Timestamp a = filterbkdtl[i]["startdate"];
                                  Timestamp b = filterbkdtl[i]["enddate"];

                                  if (selectdate!.isAtSameMomentAs(a.toDate()) ||
                                      selectdate!.isAtSameMomentAs(b.toDate())) {
                                    error = "error";
                                    showsnakbar(
                                        context, "Alreay book ", Colors.cyan,
                                        Colors.black);
                                    break;
                                  }
                                  else if (selectdate!.isAfter(a.toDate()) &&
                                      selectdate!.isBefore(b.toDate())) {
                                    error = "erroor";
                                    showsnakbar(
                                        context, "Alreay Book", Colors.cyan,
                                        Colors.black);
                                    break;
                                  }
                                }
                                if (error == "") {
                                  bookvenue();
                                }
                              }
                            },
                            child: Text("Book Venue" ,
                              style: TextStyle(
                              fontSize: 20.0,
                            ),),
                          ),


                        ],
                      ),
                    ),
                  )
                  //single date over//

                      :

                      //mutidate//

                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    width:150.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2.0 , color: Colors.black),
                                    ),
                                    child: Text( start == null ? "Start Date" : "${start!.day} / ${start!.month} / ${start!.year}" ,
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    )
                                ),

                                SizedBox(width: 20.0,),

                                Container(
                                    alignment: Alignment.center,
                                    width:150.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2.0 , color: Colors.black),
                                    ),
                                    child: Text( end == null ? "End Date" :"${end!.day} / ${end!.month} / ${end!.year}",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    )
                                ),
                              ],
                            ),



                            SizedBox(height: 30,),

                            IconButton(
                              onPressed: () async {
                                DateTimeRange? datetimerange = await showDateRangePicker
                                  (
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2024),
                                );
                                setState(() {
                                  start = datetimerange!.start;
                                  end = datetimerange.end;
                                  double totalhours = datetimerange.duration.inHours.toDouble();
                                  double rentperhour = double.parse(widget.venuedata["RentPerHour"]);
                                  if(totalhours == 0)
                                  {
                                    rent = rentperhour * 24;
                                  }
                                  else
                                  {
                                    rent = rentperhour * totalhours + rentperhour*24
                                    ;
                                  }

                                });
                              },
                              icon: Icon(Icons.calendar_month , size: 40.0,),
                            ),


                            SizedBox(height: 30.0,),


                            Divider(height: 5.0, color: Colors.black,),

                            SizedBox(height: 40.0,),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                    alignment: Alignment.center,
                                    width:300.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2.0 , color: Colors.black),
                                    ),
                                    child: Text("Total Rent :  ${rent == null ? "0 ₹" : "${rent} ₹"} ",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    )
                                ),

                              ],
                            ),


                            SizedBox(height: 30.0,),

                            RaisedButton(
                              shape: StadiumBorder(),
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: ()
                              {
                                if(start == null || end == null)
                                {
                                  showsnakbar(context, "Select date", Colors.cyan, Colors.black);
                                }
                                else if(filterbkdtl.isEmpty)
                                {
                                  bookvenuerange();
                                }
                                else if(filterbkdtl.isNotEmpty)
                                {
                                  for(int i = 0; i<filterbkdtl.length ; i++)
                                  {
                                    error = "";

                                    Timestamp a = filterbkdtl[i]["startdate"];
                                    Timestamp b = filterbkdtl[i]["enddate"];

                                    if (start!.isAfter(a.toDate()) && end!.isBefore(b.toDate()))
                                    {
                                      error = "erroor";
                                      showsnakbar(context, "Alreay Book", Colors.cyan, Colors.black);
                                      break;
                                    }
                                    else if (a.toDate().isAfter(start!) && b.toDate().isBefore(end!))
                                    {
                                      error = "erroor";
                                      showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                                      break;
                                    }
                                    else if (start!.isAfter(a.toDate()) && start!.isBefore(b.toDate()))
                                    {
                                      error = "erroor";
                                      showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                                      break;
                                    }
                                    else if (end!.isAfter(a.toDate()) && end!.isBefore(b.toDate()))
                                    {
                                      error = "erroor";
                                      showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                                      break;
                                    }
                                    else if (start!.isAtSameMomentAs(a.toDate()) || start!.isAtSameMomentAs(b.toDate()))
                                    {
                                      error = "erroor";
                                      showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                                      break;
                                    }
                                    else if (end!.isAtSameMomentAs(a.toDate()) || end!.isAtSameMomentAs(b.toDate()))
                                    {
                                      error = "erroor";
                                      showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                                      break;
                                    }
                                  }

                                  if(error == "")
                                  {
                                    bookvenuerange();
                                  }
                                  else
                                  {
                                    print("not available");
                                  }

                                }
                              },
                              child: Text("Book Venue" ,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                      //multidate over//



                  //over//

                ],
              ),
            ),
          );



        },
      )
    );
  }
}


/*
return Column(
            children: [

              SizedBox(height: 100.0,),

              //dropdown button //
              Container(
                height: 90.0,
                width: 500.0,
                alignment: AlignmentDirectional.center,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 70.0 , bottom: 10.0 , right: 60.0 , top: 20.0),
                  child: DropdownButton(
                    hint: Text("select day"),
                    dropdownColor: Colors.green.shade300,
                    value: selectedday,
                    onChanged: (finalstatevalue){
                      setState(() {
                        selectedday = finalstatevalue.toString();
                      });
                    },
                    items: days.map((newstatevalue){
                      return DropdownMenuItem<String>(
                          child: Text(newstatevalue ,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        value: newstatevalue,
                      );
                    },
                    ).toList(),
                  ),
                ),
              ),

              SizedBox(height: 10.0,),

              Divider(height: 3.0 , color: Colors.black,),


              // date select code //

              selectedday == "1 day" ?

        Container(
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    SizedBox(height: 130.0,),

                    selectdate == null ? Text("selected date")  :  Text("${selectdate!.day} / ${selectdate!.month} / ${selectdate!.year}") ,

                    SizedBox(height: 10.0,),

                       IconButton(
                                onPressed: () async
                                {
                                    datepicker = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2024),
                                    );
                                    setState(() {
                                      selectdate = datepicker;
                                       double rentperhour = double.parse(widget.venuedata["RentPerHour"]);
                                       rent = rentperhour * 24;
                                    });
                                },
                               icon: Icon(Icons.calendar_month , size: 30.0,),
                            ),

                   SizedBox(height: 10.0,),


                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                       Text("Total Rent : "),

                       Text(rent == null ? "0 ₹" : "${rent} ₹"),

                     ],
                   ),





                   SizedBox(height: 10.0,),

                     RaisedButton(
                       onPressed: ()
                        {
                             if(selectdate == null)
                             {
                                showsnakbar(context, "Select date", Colors.cyan, Colors.black);
                             }
                             else if(filterbkdtl.isEmpty)
                             {
                                bookvenue();
                             }
                             else if(filterbkdtl.isNotEmpty) {
                               for (int i = 0; i < filterbkdtl.length; i++) {
                                 error = "";
                                 Timestamp a = filterbkdtl[i]["startdate"];
                                 Timestamp b = filterbkdtl[i]["enddate"];

                                 if (selectdate!.isAtSameMomentAs(a.toDate()) ||
                                     selectdate!.isAtSameMomentAs(b.toDate())) {
                                   error = "error";
                                   showsnakbar(
                                       context, "Alreay book ", Colors.cyan,
                                       Colors.black);
                                   break;
                                 }
                                 else if (selectdate!.isAfter(a.toDate()) &&
                                     selectdate!.isBefore(b.toDate())) {
                                   error = "erroor";
                                   showsnakbar(
                                       context, "Alreay Book", Colors.cyan,
                                       Colors.black);
                                   break;
                                 }
                               }
                               if (error == "") {
                                 bookvenue();
                               }
                             }
                        },
                           child: Text("submit"),
                     ),


                 ],
             ),
           ),


          )
// booking manage //
//over//

*/










// single date proper coding //
/*
 Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 300.0,),

                  selectdate == null ? Text("selected date")  : Text("${selectdate!.day} / ${selectdate!.month} / ${selectdate!.year}") ,

                  SizedBox(height: 10.0,),

                  IconButton(
                    onPressed: () async {
                      datepicker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2024),
                      );

                      setState(() {
                        selectdate = datepicker;
                      });
                    },
                    icon: Icon(Icons.calendar_month , size: 30.0,),
                  ),

                  SizedBox(height: 10.0,),

                  RaisedButton(
                    onPressed: ()
                    {
                      if(selectdate == null)
                      {
                        showsnakbar(context, "Select date", Colors.cyan, Colors.black);
                      }
                      else if(filterbkdtl.isEmpty)
                      {
                        bookvenue();
                      }
                      else if(filterbkdtl.isNotEmpty)
                      {
                        for(int i=0 ; i<filterbkdtl.length ; i++)
                        {

                          error = "";
                          Timestamp a = filterbkdtl[i]["startdate"];
                          Timestamp b = filterbkdtl[i]["enddate"];

                          if(selectdate!.isAtSameMomentAs(a.toDate()) || selectdate!.isAtSameMomentAs(b.toDate()))
                          {
                            error = "error";
                            showsnakbar(context, "Alreay book ", Colors.cyan, Colors.black);
                            break;
                          }
                          else if (selectdate!.isAfter(a.toDate()) && selectdate!.isBefore(b.toDate()))
                          {
                            error = "erroor";
                            showsnakbar(context, "Alreay Book", Colors.cyan, Colors.black);
                            break;
                          }


                        }
                        if(error == "")
                        {
                          bookvenue();
                        }

                      }


                    },
                    child: Text("submit"),
                  ),

                ],
              ),
            ),
          );
*/



// date range //
/*
return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text( start == null ? "Start Date" : "${start!.day} / ${start!.month} / ${start!.year}"),


                  SizedBox(height: 20,),


                  Text( end == null ? "End Date" :"${end!.day} / ${end!.month} / ${end!.year}"),


                  SizedBox(height: 20,),

                  IconButton(
                    onPressed: () async {
                      DateTimeRange? datetimerange = await showDateRangePicker
                        (
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2024),
                      );

                      setState(() {
                        start = datetimerange!.start;
                        end = datetimerange.end;
                      });

                    },
                    icon: Icon(Icons.calendar_month),
                  ),


                  SizedBox(height: 10.0,),

                  RaisedButton(
                    onPressed: ()
                    {
                      if(start == null || end == null)
                      {
                        showsnakbar(context, "Select date", Colors.cyan, Colors.black);
                      }
                      else if(filterbkdtl.isEmpty)
                      {
                        bookvenuerange();
                      }
                      else if(filterbkdtl.isNotEmpty)
                      {
                        for(int i = 0; i<filterbkdtl.length ; i++)
                        {
                          error = "";

                          Timestamp a = filterbkdtl[i]["startdate"];
                          Timestamp b = filterbkdtl[i]["enddate"];

                          if (start!.isAfter(a.toDate()) && end!.isBefore(b.toDate()))
                          {
                            error = "erroor";
                            showsnakbar(context, "Alreay Book", Colors.cyan, Colors.black);
                            break;
                          }
                          else if (a.toDate().isAfter(start!) && b.toDate().isBefore(end!))
                          {
                            error = "erroor";
                            showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                            break;
                          }
                          else if (start!.isAfter(a.toDate()) && start!.isBefore(b.toDate()))
                          {
                            error = "erroor";
                            showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                            break;
                          }
                          else if (end!.isAfter(a.toDate()) && end!.isBefore(b.toDate()))
                          {
                            error = "erroor";
                            showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                            break;
                          }
                          else if (start!.isAtSameMomentAs(a.toDate()) || start!.isAtSameMomentAs(b.toDate()))
                          {
                            error = "erroor";
                            showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                            break;
                          }
                          else if (end!.isAtSameMomentAs(a.toDate()) || end!.isAtSameMomentAs(b.toDate()))
                          {
                            error = "erroor";
                            showsnakbar(context, "Some Date is Alreay Book ", Colors.cyan, Colors.black);
                            break;
                          }
                        }

                        if(error == "")
                        {
                          bookvenuerange();
                        }
                        else
                        {
                          print("not available");
                        }

                      }
                    },
                    child: Text("submit"),
                  ),


                ],
              ),
            ),
          );

 */