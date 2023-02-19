import 'dart:io';
import 'package:admin/screens/drawer.dart';
import 'package:admin/screens/profile.dart';
import 'package:admin/widget/button.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:page_transition/page_transition.dart';

class profilepic extends StatefulWidget {
  const profilepic({Key? key}) : super(key: key);

  @override
  State<profilepic> createState() => _profilepicState();
}

class _profilepicState extends State<profilepic> {

  User? user = FirebaseAuth.instance.currentUser;

  // VAR FOR IMAGE //
  File? img;
  final imagepicker = ImagePicker();
  String? photourl;


  // METHOD FOR IMGE PIC //
  Future imagepicmethod() async{
    final pick = await imagepicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pick != null) {
        img = File(pick.path);
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Select Image !!!",
            style: TextStyle(
                fontSize: 20.0
            ),
          ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }



  //  METHOD FOR UPLOADING IMAGE TO FIREBASE FOR LOGIN USER //
  Future uploadimage() async{
    final postid = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child("${user!.uid}/images").child("post_${postid}");
    await ref.putFile(img!);
    photourl = await ref.getDownloadURL();
    print(photourl);


    await FirebaseFirestore.instance.collection('user').doc(user!.uid)
        .update({ "photourl" : photourl })
        .then((value) => showsnakbar(context, "Your Pic Upload Successfully!!!", Colors.blue, Colors.black))
        .whenComplete(() =>
       Navigator.push(context, PageTransition(child: drawer(), type: PageTransitionType.bottomToTop , duration: Duration(seconds: 2))),
      //Navigator.pop(context),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Pic"),
      ),

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [


            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0 , color: Colors.black),
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 500.0,
              width: 400.0,
              child: img == null ? Container(
                alignment: Alignment.center,
                child: Text(
                  "No Image Selected",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 2.5 , color: Colors.black),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: 500.0,
                width: 400.0,
              ) : Image.file(img!,
                fit: BoxFit.cover,
              ),

            ),


            SizedBox( height: 50.0,),

            button(onpress: (){  imagepicmethod(); }, txtcolor: Colors.black, btncolor: Colors.blue, height: 50, widtht: 100.0, btnval: "Galary"),

                SizedBox(height: 40.0,),

               button(onpress: (){ uploadimage();  }, txtcolor: Colors.black, btncolor: Colors.blue, height: 50, widtht: 100.0, btnval: "Upload Pic"),

          ],
        ),
      ),
    );
  }
}
