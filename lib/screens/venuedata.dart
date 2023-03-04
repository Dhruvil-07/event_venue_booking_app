import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Venues"),
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
             print(finalvenue);


             return Container(
               child: ListView.builder(
                   itemCount: finalvenue.length,
                   itemBuilder: (context , index)
                   {
                     return ListTile(
                       leading: Text("${finalvenue[index]["Name"]}"),
                       title: Text("${finalvenue[index]['City']}"),
                       subtitle: Text("${finalvenue[index]['State']}"),
                     );
                   }
               ),
             );;
           },
        ),
      ),

    );
  }
}
