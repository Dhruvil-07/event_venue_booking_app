import 'package:admin/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


// GOOGLE SISGN UP METHOD //
googlelogin(BuildContext context) async
{
  GoogleSignIn googleSignIn = GoogleSignIn();
  try
  {
    var result = await googleSignIn.signIn();
    if(result != null)
    {
      final userdata = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userdata.accessToken , idToken: userdata.idToken
      );
      var finalresult = await FirebaseAuth.instance.signInWithCredential(credential)
          .then((value) async {

        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString('signupuser', userdata.idToken.toString());

      } )
          .whenComplete((){

        Navigator.pushReplacement(context, PageTransition(child: signup(), type: PageTransitionType.bottomToTop , duration: Duration(seconds: 2)) );

      });
    }
  }
  catch(e)
  {
    print(e);
  }
}




// SIGN OUT METHOD //
Future<void> logout() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove('signupuser');
  sharedPreferences.remove('reguser');
  sharedPreferences.remove('loginuser');
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}



