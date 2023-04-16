import 'dart:async';

import 'package:admin/screens/login.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../model/loginmodel.dart';
import '../widget/button.dart';

class forgetpwd extends StatefulWidget {
  const forgetpwd({Key? key}) : super(key: key);

  @override
  State<forgetpwd> createState() => _forgetpwdState();
}

class _forgetpwdState extends State<forgetpwd> {

  bool isloading = true;

  // CONTROLLER OF Form//
  final formkey = GlobalKey<FormState>();
  TextEditingController newpassword = TextEditingController();
  TextEditingController cnfnewpassword = TextEditingController();


  // For password show and hide //
  bool show = true;
  bool cshow = true;


  // User detail get methods //
  //FIREBASE AUTH INSTNACE //
  User? user = FirebaseAuth.instance.currentUser;

  // Login modelcalss object  //
  loginmodel loginuser = loginmodel();

  //var for login user data//
  String? regphoneno;

  // User Detail //
  Future<void> userdtl() async
  {
    FirebaseFirestore.instance.collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginuser = loginmodel.frommap(value.data());
      setState(() {
        regphoneno = loginuser.phoneno;
      });
      print(regphoneno);
    });
  }
  // user detail get methos over //



// Init method for value when page is load //
  void initState()
  {
    userdtl();
    super.initState();

    Timer(Duration(seconds: 3), () {
      setState(() {
        isloading = false;
      });
    });

  }
// Init method over//

  
//Update Password Method//
updatepassword() async
{
   FirebaseFirestore.instance.collection('user')
       .doc(user!.uid)
       .update({'password' : newpassword.text.toString()})
       .then((value){ showsnakbar(context, "Password Updated Successfully !!! ", Colors.cyan, Colors.black);})

       .whenComplete((){ Get.to(loginsscreen());});
}
//Update Password Method Over//


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isloading ?

      Center(
          child: Container(
              height: 100.0,
              child: Lottie.network("https://assets9.lottiefiles.com/private_files/lf30_ixykrp0i.json")
          )
      )

      :
      Container(
        color: Colors.deepPurple.withOpacity(0.2),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formkey,
            child: Column(
              children: [

                SizedBox(height: 90.0,),

                Text("Forget Password",
                  style: GoogleFonts.oswald(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3.0,
                  ),
                ),

                SizedBox(height: 10.0,),

                Container(
                  height: 280.0,
                  width: 500.0,
                  child: Center(
                    child: Lottie.asset("assets/lottie/forgotpwd.json"),

                    //Lottie.network("https://assets2.lottiefiles.com/packages/lf20_b0lj6sfx.json"),
                  ),
                ),


                //password//
                Padding(
                  padding: const EdgeInsets.only( top: 30.0 , left : 30.0 , right: 30.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        suffixIcon:  IconButton(
                          onPressed: (){
                            setState(() {
                              show = !show;
                            });
                          },
                          icon: Icon( show ? Icons.visibility_off : Icons.visibility , color: Colors.black , size: 30.0,),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        label: Text("Enter New Password" ,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                    ),
                    obscureText: show,
                    controller: newpassword,
                    cursorColor: Colors.black,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Enter Password";
                      }
                      else if(value.length >8 || value.length<6 ) {
                        return "Passwor Must be 6 to 8 chaacter";
                      }
                      else if(!RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(value))
                      {
                        return "Atleast One Small letter , Capital latter , Number , Special Character";
                      }
                    },
                  ),
                ),
                //pasword over//


                //confirm password//
                Padding(
                  padding: const EdgeInsets.only( top: 40.0 , left : 30.0 , right: 30.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        suffixIcon:  IconButton(
                          onPressed: (){
                            setState(() {
                              cshow = !cshow;
                            });
                          },
                          icon: Icon( cshow ? Icons.visibility_off : Icons.visibility , color: Colors.black , size: 30.0,),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        label: Text("Confrim Password" ,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                    ),
                    obscureText: show,
                    controller: cnfnewpassword,
                    cursorColor: Colors.black,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Enter Password";
                      }
                      else if( newpassword.text.toString() != cnfnewpassword.text.toString() )
                      {
                        return "Pasword not match";
                      }
                    },
                  ),
                ),

                //confirm paword over//


                SizedBox(height: 50.0,),

                //button//
                button(onpress: ()
                {
                  if(formkey.currentState!.validate())
                  {
                    updatepassword();
                  }
                }
                    , btncolor: Colors.black , txtcolor: Colors.white , height: 50.0 , widtht: 200.0 , btnval: 'Submit'),
                //button over//


              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*Scaffold(

        body: isloading

            ?

        Center(
            child: Container(
                height: 100.0,
                child: Lottie.network("https://assets9.lottiefiles.com/private_files/lf30_ixykrp0i.json")
            )
        )

            :

        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [

              // FORGET PASSWORD LABEL PATH //
              Positioned(
                top: 90.0,
                child: ClipPath(
                  clipper: OvalRightBorderClipper(),
                  child: Container(
                    color: Colors.cyan.shade200,
                    height: 100.0,
                    width: 300.0,
                    child: Center(

                        child: Text("Forget Password",
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        )
                    ),
                  ),
                ),
              ),


              // PHONE VERIFY PART //
              Positioned(
                top: 250.0,
                child: ClipPath(
                  clipper: RoundedDiagonalPathClipper(),
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.cyan.shade200,
                      height: 580.0,
                      width: 400.0,
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.only( top: 120.0 , left : 30.0 , right: 30.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide: BorderSide(width: 2.0 , color: Colors.black),
                                    ),
                                    suffixIcon:  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          show = !show;
                                        });
                                      },
                                      icon: Icon( show ? Icons.visibility_off : Icons.visibility , color: Colors.black , size: 30.0,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide: BorderSide(width: 2.0 , color: Colors.black),
                                    ),
                                    label: Text("Enter New Password" ,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                                controller: newpassword,
                                cursorColor: Colors.black,
                                validator: (value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return "Enter Password";
                                  }
                                },
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only( top: 50.0 , left : 30.0 , right: 30.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide: BorderSide(width: 2.0 , color: Colors.black),
                                    ),
                                    suffixIcon:  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          cshow = !cshow;
                                        });
                                      },
                                      icon: Icon( cshow ? Icons.visibility_off : Icons.visibility , color: Colors.black , size: 30.0,),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      borderSide: BorderSide(width: 2.0 , color: Colors.black),
                                    ),
                                    label: Text("Confrim Password" ,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                                controller: cnfnewpassword,
                                cursorColor: Colors.black,
                                validator: (value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return "Enter Password";
                                  }
                                  else if( newpassword.text.toString() != cnfnewpassword.text.toString() )
                                  {
                                    return "Pasword not match";
                                  }
                                },
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only( top: 60.0 , left: 50.0 , right: 30.0 ),
                              child: button(onpress: ()
                              {
                                if(formkey.currentState!.validate())
                                {
                                    updatepassword();
                                }
                              }
                                  , btncolor: Colors.black , txtcolor: Colors.cyan , height: 50.0 , widtht: 200.0 , btnval: 'Submit'),
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
        )

    );*/