import 'package:admin/screens/signup.dart';
import 'package:admin/widget/button.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class loginsscreen extends StatefulWidget {
  const loginsscreen({Key? key}) : super(key: key);

  @override
  State<loginsscreen> createState() => _loginsscreenState();
}

class _loginsscreenState extends State<loginsscreen> {

  bool show = true;

  void nav()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Padding(
                  padding: const EdgeInsets.only( bottom: 60.0),
                  child: Text("-------------------  OR --------------------",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only( bottom: 60.0),
                  child: button2(onpress: (){ nav(); } , txtcolor: Colors.black , btncolor: Colors.cyan ,height: 50.0 , widtht: 200.0,  ),
                )

              ],
            ),
          ),



          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height:  600.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.cyan.shade100,
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                   Padding(
                     padding: const EdgeInsets.only( top: 100.0 , left: 28.0),
                     child: Text("Welcome to",
                       style: TextStyle(
                         fontSize: 15.0,
                       ),
                     ),
                   ),

                    Padding(
                      padding: const EdgeInsets.only( top: 3.0 , left: 28.0),
                      child: Text("EVENTOR",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only( top: 3.0 , left: 28.0),
                      child: Text("Login And Continue",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(width: 2.0 , color: Colors.black),
                            ),
                            suffixIcon: Icon(Icons.email , size: 30.0, color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(width: 2.0 , color: Colors.black),
                            ),
                            label: Text("Enter Your Email" ,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            )
                          ),
                        cursorColor: Colors.black,
                      ),
                    ),




                    Padding(
                      padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(30.0)),
                               borderSide: BorderSide(width: 2.0 , color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(width: 2.0 , color: Colors.black),
                            ),
                            label: Text("Enter Your Email" ,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          suffixIcon: IconButton(
                            onPressed: (){
                               setState(() {
                                 show = !show;
                               });
                            },
                            icon: Icon( show ? Icons.visibility_off : Icons.visibility , color: Colors.black , size: 30.0,),
                          ),
                        ),
                        obscureText: show,
                        cursorColor: Colors.black,
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only( top: 60.0 , left: 110.0 , right: 30.0 ),
                      child: button(onpress: (){ nav(); } , btncolor: Colors.black , txtcolor: Colors.cyan , height: 50.0 , widtht: 200.0),
                    ),

                    
                  ],
                ),
              ),
            ),
          ),





        ],
      )
    );
  }
}








