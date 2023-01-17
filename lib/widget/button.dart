import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// NORMAL BUTTON //
class button extends StatefulWidget {

  GestureTapCallback onpress;
  Color btncolor;
  Color txtcolor;
  double height;
  double widtht;

  button({Key? key , required this.onpress , required this.txtcolor , required this.btncolor , required this.height , required this.widtht}) : super(key: key);

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpress,
      child: Container(
        decoration: BoxDecoration(
          color: widget.btncolor,
          borderRadius: BorderRadius.circular(30.0),
        ),
          alignment: Alignment.center,
          height: 50.0,
          width: 200.0,
          child: Text("Login",
          style: TextStyle(
            fontSize: 20.0,
            color: widget.txtcolor,
            fontWeight: FontWeight.bold,
          ),
          ),
      ),
    );
  }
}




//  ELEVATE BUTTON //

class button2 extends StatefulWidget {

  GestureTapCallback onpress;
  Color btncolor;
  Color txtcolor;
  double height;
  double widtht;

  button2({Key? key , required this.onpress , required this.txtcolor , required this.btncolor , required this.height , required this.widtht}) : super(key: key);

  @override
  State<button2> createState() => _button2State();
}

class _button2State extends State<button2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widtht,
      height: widget.height,
      child: ElevatedButton.icon(
          onPressed: widget.onpress,
          icon:Image.network("https://www.freepnglogos.com/uploads/new-google-logo-transparent--14.png"),
          label: Text("SIGN-UP" ,
          style: TextStyle(
            color: widget.txtcolor,
          ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(6),
            primary: widget.btncolor,
            side: BorderSide( width:3 , color: widget.btncolor),
            shape: RoundedRectangleBorder(
                borderRadius : BorderRadius.circular(30)
            ),
          ),
      ),
    );

  }
}
