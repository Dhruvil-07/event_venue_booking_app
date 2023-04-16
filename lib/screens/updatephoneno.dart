import 'dart:async';
import 'dart:ffi';
import 'package:admin/screens/drawer.dart';
import 'package:admin/screens/profile.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import '../model/loginmodel.dart';
import '../widget/button.dart';
import 'forgetpwd.dart';

class phoneupdate extends StatefulWidget {
  const phoneupdate({Key? key}) : super(key: key);

  @override
  State<phoneupdate> createState() => _phoneupdateState();
}

class _phoneupdateState extends State<phoneupdate> {

  bool isloading = true;

  // CONTROLLER FOR FORM //
  final formkey = GlobalKey<FormState>();
  TextEditingController phonenocontroller = TextEditingController();

  String? phoneno;
  var code;
  var contrycode = "Select Country Code"; // contry code value //
  var contryflag = ""; // country flag//
  var verify = ""; //verfiycation id //
  var otp = "";    // otp //


  //CONTRYCODE PICKER OBJECT //
  final countryPicker = const FlCountryCodePicker();

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


//update phone number//
  updatephonenumber() async
  {
    FirebaseFirestore.instance.collection('user')
        .doc(user!.uid)
        .update({'phoneno' : phonenocontroller.text.toString()})
        .then((value){ showsnakbar(context, "Phone Number Updated Successfully !!! ", Colors.cyan, Colors.black);})
        .whenComplete((){ Get.to(drawer());});
  }
//update phone number over//

//Phone number verification method//
  phoneverificationmethod() async
  {
    if(contrycode.compareTo("Select Country Code") == 0)
    {
      showsnakbar(context, "Select country code", Colors.cyan, Colors.black);
    }
    else{

      try
      {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: contrycode + phonenocontroller.text.toString(),
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            setState(() {
              verify = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
      catch(e)
      {
        print(e);
      }
    }

  }
//Phone number verification method over//


// OTP verification Method//
  otpverificationmethod() async
  {
    try
    {
      PhoneAuthCredential credential =  PhoneAuthProvider.credential(verificationId: verify, smsCode: otp);
      await FirebaseAuth.instance.currentUser!.linkWithCredential(credential)
          .then((value)
      {
         updatephonenumber();
      })
          .whenComplete(() async
      {
        await FirebaseAuth.instance.currentUser!.unlink(PhoneAuthProvider.PROVIDER_ID);
      });
    }
    on FirebaseAuthException catch(e)
    {
      showsnakbar(context, 'wrong otp', Colors.cyan, Colors.black);
    }

  }
//OTP verificatio Method Over//



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: Colors.deepPurple.withOpacity(0.2),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formkey,
            child: Column(
              children: [

                SizedBox(height: 70.0,),

                Text("Phone Number Update",
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
                    child: Lottie.asset("assets/lottie/update.json"),

                    //Lottie.network("https://assets3.lottiefiles.com/packages/lf20_smww5edn.json"),
                  ),
                ),

                SizedBox(height: 0.0,),

                // Country code //
                Padding(
                  padding: const EdgeInsets.only( top: 80.0 , ),
                  child: TextButton(
                    onPressed: () async {
                      code = await countryPicker.showPicker(context: context);
                      setState(() {
                        contrycode = code?.dialCode ?? "Select Country Code";
                      });

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          child: code != null ? code!.flagImage : null,
                        ),

                        SizedBox(width: 10.0,),

                        Text( contrycode,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                //Country Code Over //

                // phone number text field //
                Padding(
                  padding: const EdgeInsets.only( top: 10.0 , left: 30.0 , right: 30.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        suffixIcon:  IconButton(
                          onPressed: (){
                            phoneverificationmethod();
                          },
                          icon: Icon( Icons.send  , size: 30.0, color: Colors.black,),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                        ),
                        // hintText: contrycode,
                        label: Text("Enter phone number " ,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 10,
                    controller: phonenocontroller,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Enter Phone No";
                      }
                    },
                  ),
                ),
                // PHONE TEXTFIDE OVER //


                //OTP FIELD//
                Padding(
                  padding: const EdgeInsets.only( top: 20.0 , left : 45.0 , right: 30.0),
                  child: Pinput(
                    length: 6,
                    showCursor: true,
                    onChanged: (value){
                      otp = value;
                    },
                  ),
                ),
                //OTP FIELD OVER//


                SizedBox(height: 50.0,),

                button(onpress: () async {
                  //otpverificationmethod();
                  if(formkey.currentState!.validate())
                  {
                    otpverificationmethod();
                  }
                }, btncolor: Colors.black , txtcolor: Colors.white , height: 50.0 , widtht: 150.0 , btnval: 'Verify'),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*Scaffold(

      body:

      isloading

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

                            // Country code //
                            Padding(
                              padding: const EdgeInsets.only( top: 80.0 , ),
                              child: TextButton(
                                    onPressed: () async {
                                       code = await countryPicker.showPicker(context: context);
                                      setState(() {
                                       contrycode = code?.dialCode ?? "Select Country Code";
                                      });

                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Container(
                                          child: code != null ? code!.flagImage : null,
                                        ),

                                        SizedBox(width: 10.0,),

                                        Text( contrycode,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                        ),
                                        ),

                                      ],
                                    ),
                                  ),
                            ),
                            //Country Code Over //


                            // phone number text field //
                            Padding(
                              padding: const EdgeInsets.only( top: 10.0 , left: 30.0 , right: 30.0),
                              child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                                        ),
                                        suffixIcon:  IconButton(
                                          onPressed: (){
                                            phoneverificationmethod();
                                          },
                                          icon: Icon( Icons.send  , size: 30.0, color: Colors.black,),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                          borderSide: BorderSide(width: 2.0 , color: Colors.black),
                                        ),
                                        // hintText: contrycode,
                                        label: Text("Enter phone number " ,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )
                                    ),
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    maxLength: 10,
                                    controller: phonenocontroller,
                                    validator: (value)
                                    {
                                      if(value!.isEmpty)
                                      {
                                        return "Enter Phone No";
                                      }
                                    },
                                  ),
                            ),
                            // PHONE TEXTFIDE OVER //




                            //OTP FIELD//
                            Padding(
                              padding: const EdgeInsets.only( top: 20.0 , left : 45.0 , right: 30.0),
                              child: Pinput(
                                length: 6,
                                showCursor: true,
                                onChanged: (value){
                                  otp = value;
                                },
                              ),
                            ),
                            //OTP FIELD OVER//




                            // OTP VERIFICAION BUTTON//
                            Padding(
                              padding: const EdgeInsets.only( top: 35.0 , left: 50.0 , right: 30.0 ),
                              child: button(onpress: () async {
                                //otpverificationmethod();
                                if(formkey.currentState!.validate())
                                {
                                    otpverificationmethod();
                                }
                                }, btncolor: Colors.black , txtcolor: Colors.cyan , height: 50.0 , widtht: 200.0 , btnval: 'Verify'),
                            ),
                            // OTP VERIFICATION BUTTON OVER //



                          ],
                        ),
                      ),
                  ),
                ),
              ),
            )

          ],
        ),
      )

    );*/