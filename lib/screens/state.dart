import 'package:admin/screens/menuscreen.dart';
import 'package:admin/screens/venuedata.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class state extends StatefulWidget {

  String type;

  state({Key? key , required this.type}) : super(key: key);

  @override
  State<state> createState() => _stateState();
}

class _stateState extends State<state> {


  Stream<QuerySnapshot> venues = FirebaseFirestore.instance.collection('venue').snapshots();

  String? city ;
  String? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: venues,
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot  > snapshot)
        {
          List venuedatas = [];
          List statedata = [];
          List citydata = [];

           snapshot.data!.docs.map((DocumentSnapshot documentSnapshot){
                Map a = documentSnapshot.data() as Map<String,dynamic>;
                venuedatas.add(a);
                statedata.add(a["State"]);
                citydata.add(a["City"]);
           }).toList();


           final statefilter = statedata.toSet().toList();
           final cityfilter = citydata.toSet().toList();
           statefilter.sort();
           cityfilter.sort();

           return Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [


                 DropdownButton(
                   value: state,
                   onChanged: (finalstatevalue){
                     setState(() {
                       state = finalstatevalue.toString();
                     });
                   },
                   items: statefilter.map((newstatevalue){
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


                 SizedBox(height: 50.0,),


                 DropdownButton(
                   value: city,
                   onChanged: (finalcityvalue){
                     setState(() {
                       city = finalcityvalue.toString();
                     });
                   },
                   items: cityfilter.map((newcityvalue){
                     return DropdownMenuItem<String>(
                       child: Text(newcityvalue,
                       style: TextStyle(
                         fontSize: 20.0,
                       ),
                       ),
                       value: newcityvalue,
                     );
                   },
                   ).toList(),
                 ),


                 SizedBox(height: 50.0,),

                 IconButton(
                     onPressed: (){
                       if(city != null && state != null)
                         {
                            Get.to(venuedata(type: widget.type, city: city.toString(), state: state.toString()));
                         }
                       else
                         {
                           showsnakbar(context, "Plaase Select Values ", Colors.cyan, Colors.black);
                         }
                     },
                     icon: Icon(Icons.arrow_circle_right_outlined , size: 50.0,) ,
                 ),



               ],
             ),
           );
        },
      )
    );
  }
}



/*

Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Center(

            child: DropdownButton(
              value: selectedstate,
              onChanged: (finalstatevalue){
                setState(() {
                  selectedstate=finalstatevalue.toString();
                });
              },
              items: state.map((newstatevalue){
                return DropdownMenuItem<String>(
                  child: Text(newstatevalue),
                  value: newstatevalue,
                );
              },
              ).toList(),

            ),

          ),


         SizedBox(height: 20.0,),


          Center(

            child: DropdownButton(
              value: selectedcity,
              onChanged: (finalcityvalue){
                setState(() {
                  selectedcity=finalcityvalue.toString();
                });
              },
              items: selectedstate == "Gujarat" ?
                    gcity.map((newcityvalue){
                             return DropdownMenuItem<String>(
                                    child: Text(newcityvalue),
                                    value: newcityvalue,
                                    );
                                  },
                               ).toList()
                :  rcity.map((newcityvalue){
                       return DropdownMenuItem<String>(
                                  child: Text(newcityvalue),
                                  value: newcityvalue,
                                  );
                                },
                               ).toList(),


               ),

          ),
        ],
      ),
*/
