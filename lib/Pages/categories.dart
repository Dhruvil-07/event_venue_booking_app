

import 'package:admin/Pages/City.dart';
import 'package:admin/Pages/Color.dart';
import 'package:admin/Pages/model.dart';
import 'package:flutter/material.dart';

class festival extends StatefulWidget {
  const festival({Key? key}) : super(key: key);

  @override
  State<festival> createState() => _festivalState();
}

class _festivalState extends State<festival> {

  List<Model> categorylist=[
    Model(id: 1, text: "Party"),
    Model(id: 2, text: "Wedding"),
    Model(id: 3, text: "Farm-House"),
    Model(id: 4, text: "etc"),
    Model(id: 5, text: "Dance-Party"),
    Model(id: 6, text: "MusicalEvent"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories Screen",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400,
            child: GridView.builder(
              itemCount: categorylist.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisExtent: 98,
                    mainAxisSpacing: 15),
                itemBuilder: (BuildContext context, int index){

                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kprimaryLightBlue,
                      ),
                      child: Center(
                        child: Text(categorylist[index].text.toString(),
                          style:TextStyle(fontWeight: FontWeight.w600,fontSize: 20,) ,),
                      ),
                    ),
                    splashColor: Colors.grey,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CityPage()));
                    },
                  );
                },
               ),
          ),
        ),
      ),
    );
  }
}
