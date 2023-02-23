import 'package:admin/Pages/Color.dart';
import 'package:admin/Pages/Listpage.dart';
import 'package:admin/Pages/model.dart';
import 'package:flutter/material.dart';

class AreaPage extends StatefulWidget {
  const AreaPage({Key? key}) : super(key: key);

  @override
  State<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {

  List<AreaModel> Arealist=[
    AreaModel(id: 1,Area: "bandra")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Area",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400,
            child: GridView.builder(
              itemCount: Arealist.length,
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
                      child: Text(Arealist[index].Area.toString(),
                        style:TextStyle(fontWeight: FontWeight.w600,fontSize: 20,) ,),
                    ),
                  ),
                  splashColor: Colors.grey,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );;
  }
}
