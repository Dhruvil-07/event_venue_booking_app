import 'dart:async';
import 'package:admin/authentication/signinauth.dart';
import 'package:admin/screens/drawer.dart';
import 'package:admin/screens/forgetpwd.dart';
import 'package:admin/screens/home.dart';
import 'package:admin/screens/phoneauth.dart';
import 'package:admin/screens/signup.dart';
import 'package:admin/widget/button.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    }

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
            Navigator.pushReplacementNamed(context, '/drawer');
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
     Navigator.push(context, PageTransition(child: phoneauth(), type: PageTransitionType.rightToLeft , duration: Duration(seconds: 1) , reverseDuration: Duration(seconds: 1)) );
    }
  }


  // Init method for value when page is load //
  void initState()
  {
    userdtl();
    prefvalue();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // SIGN UP DETAL PART //
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
                  child: button2(onpress: (){
                        signupmethod();
                    } , txtcolor: Colors.black , btncolor: Colors.cyan ,height: 50.0 , widtht: 200.0, icon: Icons.add, btnval: "Sign-UP", iconcolor: Colors.white),
                ),

               ]
            ),
          ),
          // SIGN UP PART CLOSE //



         // LOGIN DETAIL PART //
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: SingleChildScrollView(
              child: Container(
                height:  600.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.cyan.shade100,
                child: Form(
                  key: formkey,
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



                        Padding(
                          padding: const EdgeInsets.only(top: 10.0 , left: 260.0),
                          child: button3(btnval: 'Forget Password ?' , txtcolor: Colors.black ,
                              onpress: (){
                                fpwdnav();
                             }),
                        ),



                      Padding(
                        padding: const EdgeInsets.only( top: 35.0 , left: 120.0 , right: 30.0 ),
                        child: button(onpress: ()
                        {
                          logincheck();
                        }
                        , btncolor: Colors.black , txtcolor: Colors.cyan , height: 50.0 , widtht: 200.0 , btnval: 'Login'),
                      ),

                      
                    ],
                  ),
                ),
              ),
            ),
          ),

          // LOGIN PART CLOSE //




        ],

      )
    );
  }
}








