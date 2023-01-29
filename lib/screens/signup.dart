import 'package:admin/authentication/signinauth.dart';
import 'package:admin/screens/login.dart';
import 'package:admin/widget/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/loginmodel.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  bool show = true;

  final formkey = GlobalKey<FormState>();
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();
  TextEditingController phonenocontroler = TextEditingController();

  String? email;
  String? password;
  String? uphoneno;


  // FIREBASE AUTH INSTANCE //
  User? user = FirebaseAuth.instance.currentUser;

  //USER REG METHOD FOR VREATE DOC FOR USER //
  Future<void> userreg() async
  {
    loginmodel signupfirst = loginmodel();
    signupfirst.email = email.toString();
    signupfirst.password = password.toString();
    signupfirst.phoneno = uphoneno.toString();

    FirebaseFirestore.instance.collection('user')
        .doc(user!.uid)
        .set(signupfirst.tomap())
        .then((value) async {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('reguser', user!.uid);
    })
    .catchError((e) => print(e))
    .whenComplete((){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>loginsscreen()));
    });
  }
  // userreg method close //



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [

          // LOGIN PAR DESIGN //
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.cyan.shade100,
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
                   child: button(onpress: (){ logout(); }, txtcolor:  Colors.cyan.shade100, btncolor: Colors.black ,  height: 50.0 , widtht: 200.0, btnval: 'Login'),
                 ),

              ],
            ),
          ),

        // LOGIN PART DESIGN END //


          // SIGNUP PART DESIGN //

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
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only( top: 100.0 , left: 28.0),
                          child: Text("Sign Up With",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.cyan.shade100,
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only( top: 3.0 , left: 28.0),
                          child: Text("EVENTOR",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan.shade100,
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.white),
                                ),
                                suffixIcon: Icon(Icons.email , size: 30.0, color: Colors.cyan.shade100),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.cyan.shade100),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.cyan.shade100),
                                ),
                            ),
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



                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(width: 2.0 , color: Colors.cyan.shade100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(width: 2.0 , color: Colors.cyan.shade100),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide(width: 2.0 , color: Colors.cyan.shade100),
                              ),
                              label: Text("Enter Password" ,
                                style: TextStyle(
                                  color: Colors.cyan.shade100,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    show = !show;
                                  });
                                },
                                icon: Icon( show ? Icons.visibility_off : Icons.visibility , color: Colors.cyan.shade100 , size: 30.0,),
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
                                else
                                  {
                                     password = passwordcontroler.text.toString();
                                  }
                            },
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 25.0 , right: 30.0 ),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.white),
                                ),
                                suffixIcon: Icon(Icons.phone , size: 30.0, color: Colors.cyan.shade100),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.cyan.shade100),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(width: 2.0 , color: Colors.cyan.shade100),
                                ),
                                label: Text("Enter Your Phone no" ,
                                  style: TextStyle(
                                    color: Colors.cyan.shade100,
                                  ),
                                )
                            ),
                            cursorColor: Colors.cyan.shade100,
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



                        Padding(
                          padding: const EdgeInsets.only( top: 40.0 , left: 110.0),
                          child: button(onpress: ()
                          {
                            if(formkey.currentState!.validate())
                              {
                                userreg();
                              }
                          },
                              txtcolor:  Colors.black, btncolor: Colors.cyan.shade100,  height: 50.0 , widtht: 200.0, btnval: "Sign Up"),
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

