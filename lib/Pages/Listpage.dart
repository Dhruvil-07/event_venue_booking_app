import 'package:admin/Pages/City.dart';
import 'package:admin/Pages/Color.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listout"),
      ),
      body:  ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CityPage()));
                },
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
                          height: 80,
                          width: 80,
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
              ),
            );
          }
      ),












      /*ListView.builder(
        itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 10,top: 10),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CityPage()));

                },
                child: Card(
                 // elevation: 0,
                  color: kprimaryLightBlue,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kprimaryLightBlue
                    ),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.network("https://i.pinimg.com/originals/5a/96/a1/5a96a1dae322a1b6b1fdf1d629f15996.jpg"),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Text("helloe",textAlign: TextAlign.left,),
                            Text("by"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),*/
      /*body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5,top: 20),
          child: Card(
            color: kprimaryLightBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.album),
                  title: Text("hello"),
                  subtitle: Text("hii"),
                )
              ],
            ),
          ),
        ),
      ),*/
    );



















































































    /*Scaffold(
      appBar: AppBar(
        title: Text("List Screen"
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
           *//* crossAxisAlignment: CrossAxisAlignment.stretch,*//*
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: SizedBox(height: 100,width: 190,
                            child: Center(child: Text("Festival",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),))),
                        color: kprimaryLightBlue,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: kprimaryLightBlue)
                        ),
                      ),
                      Card(
                        child: SizedBox(height: 100,width: 190,
                            child: Center(child: Text("Festival",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),))),
                        color: kprimaryLightBlue,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kprimaryLightBlue)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: SizedBox(height: 100,width: 190,
                            child: Center(child: Text("Festival",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),))),
                        color: kprimaryLightBlue,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kprimaryLightBlue)
                        ),
                      ),
                      Card(
                        child: SizedBox(height: 100,width: 190,
                            child: Center(child: Text("Festival",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),))),
                        color: kprimaryLightBlue,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kprimaryLightBlue)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: SizedBox(height: 100,width: 190,
                            child: Center(child: Text("Festival",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),))),
                        color: kprimaryLightBlue,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kprimaryLightBlue)
                        ),
                      ),
                      Card(
                        child: SizedBox(
                          height: 100,
                          width: 190,
                        child: Center(child: Text("Festival",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),))),
                        color: kprimaryLightBlue,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: kprimaryLightBlue)
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );*/
  }
}
