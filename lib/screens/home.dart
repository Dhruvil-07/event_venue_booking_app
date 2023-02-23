import 'package:admin/Pages/City.dart';
import 'package:admin/Pages/Color.dart';
import 'package:admin/Pages/TopSaler.dart';
import 'package:admin/Pages/categories.dart';
import 'package:admin/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/model.dart';
import '../widget/button.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  List<Model> categoryList=[
    Model(id: 1, text: "Party"),
    Model(id: 2, text: "Wedding"),
    Model(id: 3, text: "Farm-House"),
    Model(id: 4 , text: "MusicalEvent"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Home Screen",
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories",
                  style: TextStyle(
                    fontSize: 18,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => festival())
                    );
                  }, child: Text(
                    "More..",
                    style: TextStyle(
                    fontSize: 18,
                    color: kPrimaryColor,
                      fontWeight: FontWeight.w400
                  ),
                  ),
                  ),
                ],
              ),
          Container(
            //height: 400,
            child: GridView.builder(
              itemCount: categoryList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 98,
                  crossAxisSpacing: 15
              ), itemBuilder: (BuildContext context, int index) {

              return InkWell(

                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    color: kprimaryLightBlue
                  ),
                  child: Center(
                    child: Text(categoryList[index].text.toString(),
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                  ),
                ),
                splashColor: Colors.blue.withAlpha(30),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CityPage()));
                },
              );
            },
              clipBehavior: Clip.antiAlias,
            ),
          ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Rated",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: kPrimaryColor),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TopSaler()));
                  },
                      child: Text("More..",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: kPrimaryColor),))
                ],
              ),
             // SizedBox(height: 15,),
             Container(
               height: 400,
               child: ListView.builder(
                 itemCount: 5,
                   itemBuilder: (BuildContext context, int index){
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         decoration: BoxDecoration(
                           color: kprimaryLightBlue,
                           borderRadius: BorderRadius.circular(15)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Row(
                             children: [
                               Container(
                                 height: 50,
                                 width: 50,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   image: DecorationImage(
                                       image: NetworkImage("https://i.pinimg.com/originals/5a/96/a1/5a96a1dae322a1b6b1fdf1d629f15996.jpg"),
                                       fit: BoxFit.cover)
                                   //borderRadius: BorderRadius.circular(15)
                                 ),
                               ),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("HELLO"),
                                   Text("by")
                                 ],
                               )
                             ],
                           ),
                         ),
                       ),
                     );
                   }
               ),
             )
            ],

          ),

        ),
      ),
    );
  }
}





















































/*body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children:
        [

          button(onpress: () async
          {
            final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            await sharedPreferences.remove('loginuser')
            .whenComplete((){
              Navigator.push(context , MaterialPageRoute(builder: (context)=>loginsscreen()));
            });
          },
          btncolor: Colors.black , txtcolor: Colors.cyan , height: 50.0 , widtht: 200.0 , btnval: 'logout'),

        ],

      ),*/