import 'package:admin/screens/menuscreen.dart';
import 'package:admin/screens/venuedata.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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

           return Container(
             color: Colors.deepPurple.withOpacity(0.2),
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             child: SingleChildScrollView(
               child: Column(
                 children: [

                   SizedBox(height: 1.0,),

                      Container(
                       height: 400.0,
                       width: 600.0,
                       child: Lottie.network("https://assets3.lottiefiles.com/packages/lf20_Sw60y11Cpf.json"),
                     ),

                   SizedBox(height: 20.0,),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                       //State//
                       DropdownButton(
                         dropdownColor: Colors.deepPurple.shade100,
                         borderRadius:BorderRadius.all(Radius.circular(20.0)) ,
                         hint: Text("Select State" ,
                           style: TextStyle(
                           ),
                         ),
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

                       SizedBox(width: 40.0),

                       //city//
                       DropdownButton(
                         dropdownColor: Colors.deepPurple.shade100,
                         borderRadius:BorderRadius.all(Radius.circular(20.0)) ,
                         hint: Text("Select City" ,
                           style: TextStyle(
                             fontSize: 17.0,
                           ),
                         ),
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
                       //over//

                     ],
                   ),
                   //over//


                   SizedBox(height: 30.0,),


                   Divider(height: 5.0, color: Colors.black,),

                   SizedBox(height: 50.0,),


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
                           child: Text("${widget.type}",
                             style: TextStyle(
                               fontSize: 17.0,
                             ),
                           )
                       ),
                     ],
                   ),

                   SizedBox(height: 30.0,),

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
                           child: Text("${state}",
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
                           child: Text("${city}",
                             style: TextStyle(
                               fontSize: 17.0,
                             ),
                           )
                       ),


                     ],
                   ),

                   SizedBox(height: 30.0,),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                       RaisedButton(
                         shape: StadiumBorder(),
                           color: Colors.black,
                           textColor: Colors.white,
                           onPressed: (){
                             Get.to(venuedata(type: widget.type, city: city.toString(), state: state.toString()));
                           },
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [

                               Text("Go...." ,
                               style: TextStyle(
                                 fontSize: 25.0,
                               ),
                               ),

                               Icon(Icons.arrow_right),
                             ],
                           ),
                       ),

                     ],
                   ),




                 ],
               ),
             ),
           );
        },
      )
    );
  }
}

/*Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [


                 //State//
                 DropdownButton(
                   hint: Text("Select State" ,
                   style: TextStyle(
                     fontSize: 17.0,
                   ),
                   ),
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
                 //State over//


                 SizedBox(height: 50.0,),


                 //City//
                 DropdownButton(
                   hint: Text("Select City" ,
                     style: TextStyle(
                       fontSize: 17.0,
                     ),
                   ),
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
                 //City over//

                 SizedBox(height: 50.0,),

                 //button//
                 IconButton(
                     onPressed: (){
                       if(city != null && state != null)
                         {

                         }
                       else
                         {
                           showsnakbar(context, "Plaase Select Values ", Colors.cyan, Colors.black);
                         }
                     },
                     icon: Icon(Icons.arrow_circle_right_outlined , size: 50.0,) ,
                 ),
                 //butto over//


               ],
             ),
           );*/

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
