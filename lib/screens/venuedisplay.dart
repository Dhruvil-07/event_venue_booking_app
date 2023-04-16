import 'package:admin/screens/booking.dart';
import 'package:admin/screens/venuedata.dart';
import 'package:admin/widget/button.dart';
import 'package:admin/widget/snackbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class venuedisplay extends StatefulWidget {

  Map<String,dynamic> venuedata;

   venuedisplay({Key? key , required this.venuedata}) : super(key: key);

  @override
  State<venuedisplay> createState() => _venuedisplayState();
}

class _venuedisplayState extends State<venuedisplay> {

  List imageurl = [];
  int activeindex = 0;

 // x

  void urlcollect()
  {
    widget.venuedata.forEach((key, value) {
      if("${key}" == "images")
        {
           for(int i = 0 ; i < value.length ; i++)
             {
                imageurl.add(value[i]["url"]);
             }
        }
    });

    print(imageurl);

  }

  void initState()
  {
    super.initState();
    urlcollect();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          //image showo design//
          Container(
            color: Colors.deepPurple.withOpacity(.1),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 550.0  ,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                  autoPlay: true,
                  reverse: false,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enableInfiniteScroll: false,
                  onPageChanged: (index , reason)
                    {
                      setState(() {
                        activeindex = index;
                      });
                    }
                ),
                itemCount: widget.venuedata["url0"] == "" ? 1 : imageurl.length,
                itemBuilder: (context , index , realindex)
                {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child : "${widget.venuedata["url0"].toString()}" == "" ?
                          Lottie.network("https://assets9.lottiefiles.com/packages/lf20_uewt8rjj.json")
                          :
                      Image.network( "${imageurl[index].toString()}",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ) ;
                } ,

            ),
          ),
          //image show desisgn over//


          //bootm detil desisgn//
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white , Colors.white,Colors.deepOrange.withOpacity(0.5) ,   ],
                   // colors: [Colors.white ,Colors.deepPurple.withOpacity(0.6) , ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0,-4),
                    blurRadius: 8.0,
                  ),
                ]
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [

                    SizedBox(height: 20.0,),

                    AnimatedSmoothIndicator(
                        activeIndex: activeindex,
                        count: widget.venuedata["url0"] == "" ? 1 : imageurl.length,
                        effect: SwapEffect(
                          dotHeight: 15.0,
                          dotWidth: 15.0,
                          activeDotColor: Colors.deepPurple,
                          dotColor: Colors.deepPurple.withOpacity(0.6),
                        ),
                    ),


                    SizedBox(height: 20.0,),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        SizedBox(width: 20.0,),

                        Icon(Icons.home , color: Colors.black , size: 30.0,),


                        SizedBox(width: 50.0,),

                        Expanded(
                            child: SizedBox(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text("${widget.venuedata["Name"]}" ,
                                style: GoogleFonts.alegreya(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            )
                        )

                      ],
                    ),

                    SizedBox(height: 20.0,),

                    Row(
                      children: [

                        SizedBox(width: 20.0,),

                        SizedBox(
                          height: 50.0,
                          width: 100.0,
                          child: Text(
                            "Address : ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),


                    Row(
                      children: [

                        SizedBox(width: 10.0,),

                        SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Icon(Icons.location_on , size: 30.0,),
                        ),

                        SizedBox(width: 10.0,),

                        Expanded(
                          child: SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0 , color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5.0),
                              height: 50.0,
                              width: 50.0,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text("${widget.venuedata["Landmark"]}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 20.0,),


                    Row(
                      children: [

                        Expanded(
                          child: SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1.0 , color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5.0),
                              height: 50.0,
                              width: 50.0,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text("${widget.venuedata["City"]}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),



                        Expanded(
                          child: SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1.0 , color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5.0),
                              height: 50.0,
                              width: 50.0,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text("${widget.venuedata["State"]}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),



                    SizedBox(height: 25.0,),

                    Row(
                      children: [

                        SizedBox(width: 20.0,),

                        SizedBox(
                          height: 50.0,
                          width: 150.0,
                          child: Text(
                            "Description : ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      children: [

                        Expanded(
                          child: SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                    border: Border.all(width: 1.0 , color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              ),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(right: 5.0 , left: 5.0),
                              height: 100.0,
                              width: 50.0,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${widget.venuedata["Description"]}",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),


                    SizedBox(height: 20.0,),

                    Row(
                      children: [


                        SizedBox(width: 20.0,),

                        SizedBox(
                          height: 50.0,
                          width: 150.0,
                          child: Text("Other Detail : " ,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )

                      ],
                    ),


                    Row(
                      children: [

                        SizedBox(width: 20.0,),


                        Expanded(
                          child: SizedBox(
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("Venue Capacity" ,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),



                        Expanded(
                          child: SizedBox(
                            width: 200.0,
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("${widget.venuedata["VenueCapacity"]} Person",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 5.0,),

                    Row(
                      children: [

                        SizedBox(width: 20.0,),


                        Expanded(
                          child: SizedBox(
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("Parking Fesility" ,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),



                        Expanded(
                          child: SizedBox(
                            width: 200.0,
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("${widget.venuedata["Parking"]}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),


                    SizedBox(height: 5.0,),

                    Row(
                      children: [

                        SizedBox(width: 20.0,),


                        Expanded(
                          child: SizedBox(
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("Rest Room" ,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),



                        Expanded(
                          child: SizedBox(
                            width: 200.0,
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("${widget.venuedata["RestRooms"]}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),


                    SizedBox(height: 5.0,),

                    Row(
                      children: [

                        SizedBox(width: 20.0,),


                        Expanded(
                          child: SizedBox(
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("Rent Per Hour" ,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),



                        Expanded(
                          child: SizedBox(
                            width: 200.0,
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("${widget.venuedata["RentPerHour"]} ₹",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),



                    SizedBox(height: 40.0,),


                    Row(
                      children: [

                        SizedBox(width: 20.0,),

                        SizedBox(
                          height: 50.0,
                          width: 250.0,
                          child: Text(
                            "Owner Detail : ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )

                      ],
                    ),

                    Row(
                      children: [

                        SizedBox(width: 20.0,),

                        Expanded(
                          child: SizedBox(
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("Owner Contact" ,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),



                        Expanded(
                          child: SizedBox(
                            width: 200.0,
                            child:SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("${widget.venuedata["DealerContact"]}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),



                    SizedBox(height: 40.0,),


                    button2(
                        onpress: (){ Get.to(booking(venuedata: widget.venuedata)) ;},
                        txtcolor: Colors.deepPurple.shade100,
                        btncolor: Colors.black,
                        height: 50.0,
                        widtht: 250,
                        icon: Icons.calendar_month,
                        btnval: "Book My Appoinment",
                        iconcolor: Colors.deepPurple.shade100,
                    )





                      ],
                    ),



                    ),
                ),
              ),

          //bottom color design over //


          Stack(
            children: [


              Padding(
                padding: const EdgeInsets.only( left: 15.0 , top: 40.0),
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: IconButton( icon: Icon(Icons.arrow_back , size: 30.0,) , onPressed:(){Navigator.pop(context);},)
                ),
              )

            ],
          )

        ],
      )
    );

  }
}

