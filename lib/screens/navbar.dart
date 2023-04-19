import 'package:admin/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/loginmodel.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {


  //FIREBASE AUTH INSTNACE //
  User? user = FirebaseAuth.instance.currentUser;

  // Login modelcalss object  //
  loginmodel loginuser = loginmodel();

  // User Detail //
  Future<void> userdtl() async
  {
    FirebaseFirestore.instance.collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginuser = loginmodel.frommap(value.data());
      setState(() {
      });
    });
  }

  // Init method for value when page is load //
  void initState()
  {
    userdtl();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          UserAccountsDrawerHeader(
              accountName: Text("${user!.displayName}" ),
              accountEmail: Text("${user!.email}" ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network("${loginuser.photourl}",
                  fit: BoxFit.fill,
                    height: 90.0,
                    width: 90.0,
                  ),
                ),
              ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                 // "https://static.vecteezy.com/system/resources/previews/002/099/717/original/mountain-beautiful-landscape-background-design-illustration-free-vector.jpg"
                "https://img.freepik.com/premium-photo/surreal-landscape-with-mountains-beautiful-nebula-full-moon_181627-1438.jpg"
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 10.0,),

          //home//
          ListTile(
            onTap: (){Navigator.pushReplacementNamed(context, "/home");},
            leading: IconButton(
                icon: Icon(Icons.home ,
                size: 25.0,
                  color: Colors.black,
                ),
                onPressed: (){ Navigator.pushReplacementNamed(context, "/home"); },
              ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Home",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          //over//

          SizedBox(height: 10.0,),

          //booking//
          ListTile(
            onTap: (){Navigator.pushReplacementNamed(context, "/booking");},
            leading: IconButton(
              icon: Icon(Icons.calendar_month,
                size: 25.0,
                color: Colors.black,
              ),
              onPressed: (){ Navigator.pushReplacementNamed(context, "/booking"); },
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Booking",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          //over//


          SizedBox(height: 10.0,),

          //profile//
          ListTile(
            onTap: (){Navigator.pushReplacementNamed(context, "/profile");},
            leading: IconButton(
              icon: Icon(Icons.person,
                size: 25.0,
                color: Colors.black,
              ),
              onPressed: (){ Navigator.pushReplacementNamed(context, "/profile"); },
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          //over//


          SizedBox(height: 10.0,),
          Divider(thickness: 2.0),

          //setting//
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.settings,
                size: 25.0,
                color: Colors.black,
              ),
              onPressed: (){},
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Setting",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          //over//


          SizedBox(height: 10.0,),

          //logout//
          ListTile(
            onTap: ()async{
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are You Sure ??? "),
                      actions: [

                        TextButton(
                          onPressed: (){ Navigator.pop(context); },
                          child: Text("Back"),
                        ),

                        TextButton(
                            onPressed: () async {
                              final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              await sharedPreferences.remove('loginuser').whenComplete(() {Navigator.pushReplacementNamed(context, "/login");});
                            },
                            child: Text("Logout")
                        ),
                      ]
                  ),
                );

            },
            leading: IconButton(
              icon: Icon(Icons.logout,
                size: 25.0,
                color: Colors.black,
              ),
              onPressed: ()async
              {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are You Sure ??? "),
                      actions: [

                        TextButton(
                          onPressed: (){ Navigator.pop(context); },
                          child: Text("Back"),
                        ),

                        TextButton(
                            onPressed: () async {
                              final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              await sharedPreferences.remove('loginuser').whenComplete(() {Navigator.pushReplacementNamed(context, "/login");});
                            },
                            child: Text("Logout")
                        ),
                      ]
                  ),
                );
              },
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          //over//

          Divider(thickness: 2.0),



        ],
      ),
    );
  }
}
