import 'package:admin/Pages/AreaPage.dart';
import 'package:admin/Pages/Color.dart';
import 'package:admin/Pages/model.dart';
import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {

  List<ModelCity> Citylist=[
    ModelCity(id: 1, city: "Mumbai"),
    ModelCity(id: 2, city: "Surat"),
    ModelCity(id: 2, city: "Vadodra"),
    ModelCity(id: 4, city: "Ahemdabad"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "City",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400,
            child: GridView.builder(
              itemCount: Citylist.length,
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
                      child: Text(Citylist[index].city.toString(),
                        style:TextStyle(fontWeight: FontWeight.w600,fontSize: 20,) ,),
                    ),
                  ),
                  splashColor: Colors.grey,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AreaPage()));
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
