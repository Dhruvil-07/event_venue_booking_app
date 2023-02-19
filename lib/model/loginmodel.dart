import 'package:flutter/material.dart';

class loginmodel
{
  String? uid;
  String? email;
  String? password;
  String? phoneno;
  String? name;
  String? photourl;

  loginmodel({ this.uid , this.email , this.password , this.phoneno , this.name , this.photourl});


  // data from firebase //
  factory loginmodel.frommap(map){
    return loginmodel(
      uid: map['uid'],
      email : map['email'],
      password: map['password'],
      phoneno: map['phoneno'],
      name: map['name'],
      photourl: map['photourl']
    );
  }

  // data to firebase //
  Map<String,dynamic> tomap(){
    return{
      'uid':uid,
      'email' : email,
      'password':password,
      'phoneno' : phoneno,
      'name' : name,
      'photourl' : photourl,
    };
  }
}
