import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class temp extends StatelessWidget {
  const temp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("temp screen"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){ ZoomDrawer.of(context)!.toggle(); },
        ),
      ),

        body: Container(
          child: ListView(
            children: [

            ],
          ),
        ),
    );
  }
}
