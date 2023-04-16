import 'dart:async';
import 'package:admin/screens/bookinsecond.dart';
import 'package:admin/screens/venuedisplay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class venuedata extends StatefulWidget {

   final String type;
   final String city;
   final String state;

  const venuedata({Key? key , required this.type , required this.city , required this.state}) : super(key: key);

  @override
  State<venuedata> createState() => _venuedataState();
}

class _venuedataState extends State<venuedata> {

  Stream<QuerySnapshot> venues = FirebaseFirestore.instance.collection('venue').snapshots();
  bool isloading = true;

  void initState()
  {
    super.initState();
    Timer(Duration(seconds: 4 ), () {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        elevation: 0.0,
        title: Text("Venue"),
      ),

      body: Container(
        child:StreamBuilder<QuerySnapshot>(
           stream: venues,
           builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot)
           {

             List venuedata = [];
             List filtervenueata = [];

             snapshot.data!.docs.map((DocumentSnapshot documentSnapshot)
             {
               Map a = documentSnapshot.data() as Map<String,dynamic>;
               venuedata.add(a);

               venuedata.forEach((element)
               {
                 if(element["City"] == widget.city && element["State"] == widget.state)
                   {
                       String type = element["Types"].toString();

                       if(type.contains(widget.type))
                         {
                            filtervenueata.add(element);
                         }
                   }
               });
             }).toList();


             List finalvenue = filtervenueata.toSet().toList();

             print(venuedata);

             return filtervenueata.isEmpty ?

                Center(
                       child: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_scgyykem.json")
                 )

                 :


             isloading
                 ?  Center(
                             child: Container(
                               height: 150.0,
                                 child: Lottie.network("https://assets9.lottiefiles.com/private_files/lf30_ixykrp0i.json")
                             )
                         )
                 :Container(
                           color: Colors.deepPurple.withOpacity(0.5),
                           child: ListView.builder(
                               itemCount: finalvenue.length,
                               itemBuilder: (context , index)
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
                                           height: 300.0,
                                           width: 400.0,
                                           padding: EdgeInsets.all(10.0),
                                           child: Container(
                                             margin: EdgeInsets.only(top: 5.0 , bottom: 70.0, ),
                                             width: 400.0,
                                             height: 200.0,
                                             child: ClipRRect(
                                               borderRadius: BorderRadius.circular(10.0),
                                               child: "${finalvenue[index]["url0"].toString()}" == "" ?
                                                   Lottie.network("https://assets9.lottiefiles.com/packages/lf20_uewt8rjj.json")
                                                   :
                                               Image.network( "${finalvenue[index]["url0"].toString()}",
                                                 fit: BoxFit.fitWidth,
                                               ),
                                             ),
                                           ),
                                         ),
                                         semanticContainer: true,
                                         clipBehavior: Clip.antiAliasWithSaveLayer,
                                         margin: EdgeInsets.all(10.0),
                                         color: Colors.grey[200],
                                         shadowColor: Colors.grey[800],
                                         borderOnForeground: true,
                                       ),
                                       onTap: (){ Get.to(venuedisplay(venuedata: finalvenue[index],)); },
                                     ),


                                     Positioned(
                                       top:250.0,
                                       child: Container(
                                           width: 300,
                                           padding: const EdgeInsets.only(left: 40.0),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [

                                               Text("${finalvenue[index]["Name"]}" ,
                                                 style: TextStyle(
                                                   color: Colors.black,
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: 20.0,
                                                 ),
                                               ),

                                               SizedBox(height: 2.0,),

                                               Text(" ${finalvenue[index]["City"]} , ${finalvenue[index]["State"]} " ,
                                                 style: TextStyle(
                                                   color: Colors.black,
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: 15.0,
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
                         );



           },
        ),
      ),

    );
  }
}
