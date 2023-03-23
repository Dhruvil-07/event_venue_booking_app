import 'dart:io';
import 'package:admin/screens/state.dart';
import 'package:admin/screens/venuedisplay.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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


  //single date bboking//
  Future<void> bookvenue()
  {
    return FirebaseFirestore.instance.collection('pbooking')
        .add({ "username" : user!.displayName.toString() , "useremail" : user!.email.toString(),
               "venueownercontct" : widget.venuedata["DealerContact"] , "venuename" : widget.venuedata["Name"] , "venuedocid" : widget.venuedata["docId"],
               "venuecity" : widget.venuedata["City"] , "venuestate" : widget.venuedata["State"], "venuedocid" : widget.venuedata["docId"],
               "startdate" : selectdate , "enddate" : selectdate
        })
        .then((value){ showsnakbar(context, "booking request send succesfully !!!", Colors.cyan, Colors.black); })
        .whenComplete((){Navigator.pop(context);});
  }



  //range date booking //
  Future<void> bookvenuerange()
  {
    return FirebaseFirestore.instance.collection('pbooking')
        .add({ "username" : user!.displayName.toString() , "useremail" : user!.email.toString(),
      "venueownercontct" : widget.venuedata["DealerContact"] , "venuename" : widget.venuedata["Name"] , "venuedocid" : widget.venuedata["docId"],
      "venuecity" : widget.venuedata["City"] , "venuestate" : widget.venuedata["State"], "venuedocid" : widget.venuedata["docId"],
      "startdate" : start , "enddate" : end
    })
        .then((value){ showsnakbar(context, "booking request send succesfully !!!", Colors.cyan, Colors.black); })
        .whenComplete((){Navigator.pop(context);});
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

                    selectdate == null ? Text("selected date")  : Text("${selectdate!.day} / ${selectdate!.month} / ${selectdate!.year}") ,

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



                  :

          Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 130.0),
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
          ),
          ),






            ],
          );
          // booking manage //

          //over//



        },
      )
    );
  }
}


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