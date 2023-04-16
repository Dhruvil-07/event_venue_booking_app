import 'dart:async';

import 'package:admin/authentication/signinauth.dart';
import 'package:admin/screens/login.dart';
import 'package:admin/widget/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/loginmodel.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  bool isloading = true;
  bool show = true;

  final formkey = GlobalKey<FormState>();
  String? emailcontroller;
  TextEditingController passwordcontroler = TextEditingController();
  TextEditingController phonenocontroler = TextEditingController();

  String? email;
  String? password;
  String? uphoneno;


  // FIREBASE AUTH INSTANCE //
  User? user = FirebaseAuth.instance.currentUser;

  //USER REG METHOD FOR CREATE DOC FOR USER //
  Future<void> userreg() async
  {
    loginmodel signupfirst = loginmodel();
    signupfirst.uid = user!.uid.toString();
    signupfirst.email = email.toString();
    signupfirst.password = password.toString();
    signupfirst.phoneno = uphoneno.toString();
    signupfirst.name = user!.displayName.toString();

    FirebaseFirestore.instance.collection('user')
        .doc(user!.uid)
        .set(signupfirst.tomap())
        .then((value) async {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('reguser', user!.uid);
    })
    .catchError((e) => print(e))
    .whenComplete((){

        Get.to(loginsscreen());
         // Navigator.pushReplacement(context, PageTransition(child: loginsscreen(), type: PageTransitionType.topToBottom , duration: Duration(seconds: 2)) );
    });
  }
  // userreg method close //



  void initState()
  {
    super.initState();
    setState(() {
      emailcontroller = user!.email.toString();
    });

    Timer(Duration(seconds: 3), () {
      setState(() {
        isloading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading ?

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

                SizedBox(height: 80.0,),

              Text("Sign Up",
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
                  child: Lottie.asset("assets/lottie/signup.json"),

                  // Lottie.network("https://assets9.lottiefiles.com/packages/lf20_mjlh3hcy.json"),
                ),
              ),


              SizedBox(height: 20.0,),

                  //email//
                  Padding(
                    padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 3.0 , color: Colors.black),
                        ),
                      ),
                      enabled: false,
                      cursorColor: Colors.cyan,
                      initialValue: user!.email,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Enter Email ";
                        }
                        else
                        {
                          email = user!.email;
                        }
                      },
                    ),
                  ),
                  //emai over //


                  SizedBox(height: 0.0,),

                  //password//
                  Padding(
                    padding: const EdgeInsets.only( top: 30.0 , left: 25.0 , right: 30.0 ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        label: Text("Enter Password" ,
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
                          icon: Icon( show ? Icons.visibility_off : Icons.visibility , color: Colors.black, size: 30.0,),
                        ),
                      ),
                      obscureText: show,
                      cursorColor: Colors.black,
                      controller: passwordcontroler,
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
                        else
                        {
                          password = passwordcontroler.text.toString();
                        }
                      },
                    ),
                  ),
                  //pasword over//

                  //phone number//
                  Padding(
                    padding: const EdgeInsets.only( top: 30.0 , left: 25.0 , right: 30.0 ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(width: 2.0 , color: Colors.black),
                          ),
                          suffixIcon: Icon(Icons.phone , size: 30.0, color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(width: 2.0 , color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(width: 2.0 , color: Colors.black),
                          ),
                          label: Text("Enter Your Phone no" ,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                      ),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: phonenocontroler,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Enter Phoneno";
                        }
                        else
                        {
                          setState(() {
                            uphoneno = phonenocontroler.text.toString();
                          });
                        }
                      },
                    ),
                  ),
                  //pon number over//


                  SizedBox(height: 30.0,),

                  //signup button//
                  button(onpress: ()
                  {
                    if(formkey.currentState!.validate())
                    {
                      userreg();
                    }
                  },
                      txtcolor:  Colors.white, btncolor: Colors.black,  height: 50.0 , widtht: 200.0, btnval: "Sign Up"),
                  //signup button over//


                  //login//
                  SizedBox(height: 20.0,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("----------------------------------  OR ------------------------------------",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  //login  over//


                  SizedBox(height: 15.0,),

                  //Login Button //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      button(onpress: ()
                      {
                        Get.to(loginsscreen());
                      }
                          , btncolor: Colors.black, txtcolor: Colors.white , height: 50.0 , widtht: 200.0 , btnval: 'Login'
                      ),
                    ],
                  ),
                  //login button over//


                ],
              ),
            ),
        ),
      ),
    );
  }
}