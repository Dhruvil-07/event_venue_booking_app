import 'package:admin/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [


          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.cyan,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                  Padding(
                    padding: const EdgeInsets.only(top: 90.0 , left: 20.0),
                    child: Text("Existing User ? ",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                    ),
                  ),

                 Padding(
                   padding: const EdgeInsets.only( top: 20.0 , left: 15.0),
                   child: button(onpress: (){print("hello");}, txtcolor:  Colors.cyan, btncolor: Colors.black ,  height: 50.0 , widtht: 200.0,),
                 ),

              ],
            ),
          ),




          Padding(
            padding: const EdgeInsets.only(top:300.0),
            child: ClipPath(
              clipper: OvalTopBorderClipper(),
              child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only( top: 100.0 , left: 28.0),
                          child: Text("Sign Up With",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.cyan,
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only( top: 3.0 , left: 28.0),
                          child: Text("EVENTOR",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan,
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.white),
                                ),
                                suffixIcon: Icon(Icons.email , size: 30.0, color: Colors.cyan),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.cyan),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.cyan),
                                ),
                                label: Text("Enter Your Email" ,
                                  style: TextStyle(
                                    color: Colors.cyan,
                                  ),
                                )
                            ),
                            cursorColor: Colors.cyan,
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(width: 2.0 , color: Colors.cyan),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(width: 2.0 , color: Colors.cyan),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(width: 2.0 , color: Colors.cyan),
                              ),
                              label: Text("Enter Your Email" ,
                                style: TextStyle(
                                  color: Colors.cyan,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    show = !show;
                                  });
                                },
                                icon: Icon( show ? Icons.visibility_off : Icons.visibility , color: Colors.cyan , size: 30.0,),
                              ),
                            ),
                            obscureText: show,
                            cursorColor: Colors.black,
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.white),
                                ),
                                suffixIcon: Icon(Icons.phone , size: 30.0, color: Colors.cyan),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.cyan),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.cyan),
                                ),
                                label: Text("Enter Your Phone no" ,
                                  style: TextStyle(
                                    color: Colors.cyan,
                                  ),
                                )
                            ),
                            cursorColor: Colors.cyan,
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 110.0),
                          child: button(onpress: (){print("hello");}, txtcolor:  Colors.black, btncolor: Colors.cyan,  height: 50.0 , widtht: 200.0,),
                        ),




                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),

    );
  }
}

