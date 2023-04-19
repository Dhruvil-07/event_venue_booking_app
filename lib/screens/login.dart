import 'dart:async';
import 'package:admin/authentication/signinauth.dart';
import 'package:admin/screens/drawer.dart';
import 'package:admin/screens/forgetpwd.dart';
import 'package:admin/screens/home.dart';
import 'package:admin/screens/phoneauth.dart';
import 'package:admin/screens/signup.dart';
import 'package:admin/widget/button.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:carousel_slider/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/loginmodel.dart';

class loginsscreen extends StatefulWidget {
  const loginsscreen({Key? key}) : super(key: key);

  @override
  State<loginsscreen> createState() => _loginsscreenState();
}

class _loginsscreenState extends State<loginsscreen>  {

  bool show = true;
  bool isloading = true;

  // form key and controler //
  final formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();



  //FIREBASE AUTH INSTNACE //
  User? user = FirebaseAuth.instance.currentUser;

  // Login modelcalss object  //
  loginmodel loginuser = loginmodel();

  //var for login user data//
  String? email;
  String? password;

  // User Detail //
  Future<void> userdtl() async
  {
    FirebaseFirestore.instance.collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginuser = loginmodel.frommap(value.data());
      setState(() {
        email = loginuser.email;
        password = loginuser.password;
        print(email);
        print(password);
      });
    });
  }




  // var for prefs //
  var signupuser;
  var reguser;
  var loginuserdtl;

  // SHARED PREFRENCES VLUES //
  Future<void> prefvalue() async
  {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    signupuser = sharedPreferences.get('signupuser');
    reguser = sharedPreferences.get('reguser');
    loginuserdtl = sharedPreferences.get('loginuser');

    print(signupuser);
    print(reguser);
    print(loginuserdtl);
  }



  // METHOD FOR SIGNUP //
  signupmethod() async
  {
    /*
    if(signupuser == null && reguser == null)
    {
      googlelogin(context);
    }
    else if(signupuser != null && reguser == null)
    {
      showsnakbar(context, "Register first ", Colors.cyan, Colors.black);
      Timer(Duration(seconds: 3), ()=> Navigator.pushReplacement(context, PageTransition(child: signup(), type: PageTransitionType.bottomToTop , duration: Duration(seconds: 2) , reverseDuration: Duration(seconds: 2))));

    }
    else if( signupuser != null && reguser != null)
    {
      showsnakbar(context, "already register" , Colors.cyan , Colors.black);
    }*/

    googlelogin(context);

  }




  // Checking login credentical //
  logincheck() async
  {
    if(formkey.currentState!.validate())
      {
        if(emailcontroller.text.toString() == email  && passwordcontroller.text.toString() == password)
        {
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('loginuser', email!)
              .whenComplete((){
           // Navigator.pushReplacement(context, PageTransition(child: drawer(), type: PageTransitionType.rightToLeft , alignment: Alignment.center , duration: Duration(seconds: 3)));
            Navigator.pushReplacementNamed(context, '/home');
          });
        }
        else if(signupuser == null)
        {
          showsnakbar(context, "Sign up First", Colors.cyan, Colors.black);
        }
        else if(signupuser != null && reguser == null)
        {
          showsnakbar(context, "Registration step Incomplete", Colors.cyan, Colors.black);
        }
        else
        {
          showsnakbar(context, "Wrong Detail", Colors.cyan , Colors.black);
        }
      }
  }



  // Forget Password Navgation //

  fpwdnav() async
  {
    if(signupuser == null)
    {
      showsnakbar(context, "Sign up First", Colors.cyan, Colors.black);
    }
    else if(signupuser != null && reguser == null)
    {
      showsnakbar(context, "Registration step Incomplete", Colors.cyan, Colors.black);
    }
    else
    {
       Get.to(phoneauth());
    }
  }


  // Init method for value when page is load //
  void initState()
  {
    userdtl();
    prefvalue();
    super.initState();
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
          scrollDirection:Axis.vertical,
            child: Form(
              key: formkey,
              child: Column(

                children: [

                  SizedBox(height: 50.0,),

                  Text("Login",
                    style: GoogleFonts.oswald(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3.0,
                    ),
                  ),


                  SizedBox(height: 20.0,),

                  Container(
                    height: 280.0,
                    width: 500.0,
                    child: Center(
                      child: Lottie.asset("assets/lottie/login.json"),

                      //Lottie.network("https://assets7.lottiefiles.com/packages/lf20_xlmz9xwm.json"),
                    ),
                  ),

                  SizedBox(height: 10.0,),

                  //email //
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
                      controller: emailcontroller,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Enter Email";
                        }
                      },

                    ),
                  ),
                  //email over //


                  //pasword//
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
                          icon: Icon( show ? Icons.visibility_off : Icons.visibility , color: Colors.black , size: 30.0,),
                        ),
                      ),
                      obscureText: show,
                      cursorColor: Colors.black,
                      controller: passwordcontroller,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Enter password";
                        }

                      },

                    ),
                  ),
                  //pasword over//



                  //foeget pasword //
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0 , left: 240.0 , ) ,
                    child: button3(btnval: 'Forget Password ?' , txtcolor: Colors.black ,
                        onpress: (){
                          fpwdnav();
                        }),
                  ),
                  //forget paword over//


                  SizedBox(height: 15.0,),

                  //Login Button //
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         button(onpress: ()
                        {

                              logincheck();
                        }
                          , btncolor: Colors.black, txtcolor: Colors.white , height: 50.0 , widtht: 200.0 , btnval: 'Login'
                        ),
                       ],
                     ),
                  //login button over//


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


                  SizedBox(height: 20.0,),

                  button2(onpress: (){
                signupmethod();
              } , txtcolor: Colors.white , btncolor: Colors.black ,height: 50.0 , widtht: 200.0, icon: Icons.add, btnval: "Sign-UP", iconcolor: Colors.white,
              ),


                ],

              ),
            ),
        ),
      ),
    );
  }
}

