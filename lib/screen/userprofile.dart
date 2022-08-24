import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Utils.dart';
import 'sidenavigation.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";
  late SharedPreferences sharedPreferences;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("name");
      var emailValue = sharedPreferences.getString("email");
      var _imageValue = sharedPreferences.getString("image");
      var _phoneValue = sharedPreferences.getString("phoneno");
      setState(() {
        name = _testValue!;
        email = emailValue!;
        phone = _phoneValue!;
        iamge = _imageValue!;
        //  print(name+" "+email+" "+phone+" "+_imageValue);
      });
      // will be null if never previously saved
      // print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(

        child: Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/svgicons/profilebackgound.png'),
              fit: BoxFit.fill)),
      child: Scaffold(
        key: scaffolKey,
        drawer:  SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(Utils.hexStringToHexInt('77ACA2')),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              scaffolKey.currentState!.openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.all(6),
              child: Image.asset(
                'images/svgicons/noti.png',
                width: width * 0.08,
                height: height * 0.08,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            elevation: 12,
                            child: Container(
                                width: width * 0.9,
                                height: height * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.04)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[],
                                )),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: -height * 0.04,
                      left: width * 0.4,
                      child: CircleAvatar(
                        radius: width * 0.10,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1597466765990-64ad1c35dafc"),
                        foregroundColor: Colors.black,
                      ),
                    ),
                    Positioned(
                        top: height * 0.07,
                        child: Container(
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Dr. Kevin Williams',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins Medium',
                                    fontSize: width * 0.04),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 16,
                                    height: 16,
                                    child: SvgPicture.asset(
                                      "images/svgicons/mappin.svg",
                                      color: Color(
                                          Utils.hexStringToHexInt('A3A2A2')),
                                    ),
                                  ),
                                  Text(' Galleria, Ghaziabad',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontFamily: 'Poppins Regular',
                                          color: Color(Utils.hexStringToHexInt(
                                              'A3A2A2'))),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                              Container(
                                width: width * 0.7,
                                child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id tincidunt faucibus sed euismod nunc ultricies suspendisse sed.',
                                  style: TextStyle(
                                      color: Color(
                                          Utils.hexStringToHexInt('A3A2A2')),
                                      fontSize: width * 0.03),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: width,
                                height: height * 0.1 + height * .04,
                                alignment: Alignment.center,
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text('Your Activity',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins Regular',
                                                  color: Colors.black)),
                                          Text(''),
                                          RatingBarIndicator(
                                            rating: 2.75,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 18.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                      VerticalDivider(
                                        color: Color(
                                            Utils.hexStringToHexInt('E6E8EA')),
                                        thickness: 2,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            'Your Rating',
                                            style: TextStyle(
                                                fontFamily: 'Poppins Regular',
                                                color: Colors.black),
                                          ),
                                          Text('4.5',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins medium',
                                                  color: Colors.black,
                                                  fontSize: width * 0.04)),
                                          RatingBarIndicator(
                                            rating: 2.75,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 18.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                  margin:
                      EdgeInsets.only(left: width * 0.04, right: width * 0.04),
                  child: seeall(context)),
              wishlist(context, width, height)
            ],
          ),
        ),
      ),
    ));
  }

  Widget wishlist(BuildContext context, width, height) {
    return Card(
      child: Stack(
        clipBehavior: Clip.none,

        children: <Widget>[
          Row(
            children: <Widget>[
              /*TODO---Saloon image*/
              Expanded(
                flex: 3,
                child: Container(
                    margin: EdgeInsets.only(left: 8),
                    height: MediaQuery.of(context).size.height * 0.2 -
                        height * 0.03,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage('images/svgicons/saloonimage.png'),
                          fit: BoxFit.fill,
                        ))),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.08,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '     Services : Hair Styling , Makeup',
                                    style: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('9B9B9B')),
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.02),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '',
                                    style: TextStyle(
                                        color: Color(
                                            Utils.hexStringToHexInt('9B9B9B')),
                                        fontFamily: 'Poppins Regular',
                                        fontSize: width * 0.03),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container())
            ],
          ),
          // /*TODO--femina text*/
          Positioned(
            top: 4,
            left: 130,
            child: Text(
              'Femina Beauty Salon',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontFamily: 'Poppins Regular'),
            ),
          ),

          /*TODO---address*/
          Positioned(
            top: height * 0.04,
            left: 130,
            child: Text(
              'Near Dundheri , Ghaziabad',
              style: TextStyle(
                  color: Color(Utils.hexStringToHexInt('A3A2A2')),
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontFamily: 'Poppins Regular'),
            ),
          ),
          Positioned(
            top: height * 0.07,
            left: 130,
            child: Text(
              'Feb 10, 12:00 PM - 2:00 PM ',
              style: TextStyle(
                  color: Color(Utils.hexStringToHexInt('A3A2A2')),
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  fontFamily: 'Poppins Regular'),
            ),
          ),
          Positioned(
              top: height * 0.1 + height * 0.02,
              right: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    padding: EdgeInsets.all(width * 0.01),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(Utils.hexStringToHexInt('#e5e5e5')),
                          width: 2,
                        ),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(6))),
                    child: Center(
                      child: Text(
                        'Makeup',
                        style: TextStyle(
                            fontFamily: 'Poppins Regular',
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Color(Utils.hexStringToHexInt('000000'))),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    margin: EdgeInsets.only(left: 2),
                    padding: EdgeInsets.all(width * 0.01),
                    decoration: BoxDecoration(
                        color: Color(Utils.hexStringToHexInt('77ACA2')),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(6))),
                    child: Center(
                      child: Text(
                        'Makeup',
                        style: TextStyle(
                          fontFamily: 'Poppins Regular',
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget seeall(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Utils().titleText('My Bookings', context),
        Text(
          'See all',
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              fontSize: MediaQuery.of(context).size.height * 0.02,
              color: Color(Utils.hexStringToHexInt('#77aca2'))),
        )
      ],
    );
  }
}
