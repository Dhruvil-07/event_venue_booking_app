import 'package:admin/screens/booking.dart';
import 'package:admin/screens/venuedata.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class venuedisplay extends StatefulWidget {

  Map<String,dynamic> venuedata;

   venuedisplay({Key? key , required this.venuedata}) : super(key: key);

  @override
  State<venuedisplay> createState() => _venuedisplayState();
}

class _venuedisplayState extends State<venuedisplay> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text(widget.venuedata["Name"]),
            onPressed: (){
              Get.to(booking(venuedata: widget.venuedata,));
            },
          ),
        ),
      ),
    );
  }
}


/*

*/
