import 'package:flutter/material.dart';

class loginmodel
{
  String? uid;
  String? email;
  String? password;
  String? phoneno;

  loginmodel({ this.uid , this.email , this.password , this.phoneno});


  // data from firebase //
  factory loginmodel.frommap(map){
    return loginmodel(
      uid: map['uid'],
      email : map['email'],
      password: map['password'],
      phoneno: map['phoneno'],
    );
  }

  // data to firebase //
  Map<String,dynamic> tomap(){
    return{
      'email' : email,
      'password':password,
      'phoneno' : phoneno,
    };
  }
}
