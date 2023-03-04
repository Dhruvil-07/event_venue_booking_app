import 'package:admin/screens/login.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../model/loginmodel.dart';
import '../widget/button.dart';

class forgetpwd extends StatefulWidget {
  const forgetpwd({Key? key}) : super(key: key);

  @override
  State<forgetpwd> createState() => _forgetpwdState();
}

class _forgetpwdState extends State<forgetpwd> {

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
  }
// Init method over//

  
//Update Password Method//
updatepassword() async
{
   FirebaseFirestore.instance.collection('user')
       .doc(user!.uid)
       .update({'password' : newpassword.text.toString()})
       .then((value){ showsnakbar(context, "Password Updated Successfully !!! ", Colors.cyan, Colors.black);})

       .whenComplete((){ Navigator.pushReplacementNamed(context, "/login");})

       .whenComplete((){ Navigator.push(context, MaterialPageRoute(builder: (context)=>loginsscreen()));});

}
//Update Password Method Over//
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
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

    );
  }
}
