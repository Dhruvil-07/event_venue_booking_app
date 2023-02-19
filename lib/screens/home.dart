import 'package:admin/authentication/signinauth.dart';
import 'package:admin/screens/login.dart';
import 'package:admin/screens/temp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/button.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  Stream<QuerySnapshot> venues = FirebaseFirestore.instance.collection('venue').snapshots();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Home Screen",
        ),
        leading: IconButton(
            onPressed: (){
              ZoomDrawer.of(context)?.toggle();
            },
            icon: Icon(Icons.menu),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>
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
                  filterlist.add(element);
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
    );
  }
}







/*
StreamBuilder<QuerySnapshot>(
stream: venues,
builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot)
{
List venuedtl = [];

snapshot.data!.docs.map((DocumentSnapshot documentSnapshot){
Map a = documentSnapshot.data() as Map<String,dynamic>;
venuedtl.add(a);
print(venuedtl);
}).toList();

print(venuedtl.length);

return ListView.builder(
itemCount: venuedtl.length,
itemBuilder: (context , index)
{
return ListTile(
title: Text("${venuedtl[index]['City']}"),
);
}
);
},
)*/
