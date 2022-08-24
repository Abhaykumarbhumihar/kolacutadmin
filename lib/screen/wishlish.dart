import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screen/saloondetail.dart';
import 'package:untitled/screen/sidenavigation.dart';

import '../controller/wishlist_controller.dart';
import '../model/WishlistPojo.dart';
import '../utils/Utils.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  WishListController wishListControlller = Get.put(WishListController());
  var name = "";
  var email = "";
  var phone = "";
  var iamge = "";

  late SharedPreferences sharedPreferences;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  var session;
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var _testValue = sharedPreferences.getString("name");
      var emailValue = sharedPreferences.getString("email");
      var _imageValue = sharedPreferences.getString("image");
      var _phoneValue = sharedPreferences.getString("phoneno");
      var _sessss = sharedPreferences.getString("session");

      setState(() {
        if(_testValue!=null){
          session=_sessss;
          name = _testValue!;
          email = emailValue!;
          phone = _phoneValue!;
          iamge = _imageValue!;
        }else{
          name = "";
          email ="";
          phone ="";
          iamge ="";
        }
        //  print(name+" "+email+" "+phone+" "+_imageValue);
      });
      // will be null if never previously saved
      // print("SDFKLDFKDKLFKDLFKLDFKL  " + "${_testValue}");
    });
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
            key: scaffolKey,
            drawer:  SideNavigatinPage("${name}", "${iamge}", "${email}", "${phone}"),
            backgroundColor: Color(Utils.hexStringToHexInt('E5E5E5')),
            appBar: AppBar(
              backgroundColor: Colors.white,
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
              title: Text(
                'Your Wishlist',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins Medium',
                    fontSize: width * 0.04),
              ),
              actions: <Widget>[
                // Container(
                //   margin: EdgeInsets.all(6),
                //   child: Image.asset('images/svgicons/filterr.png'),
                // )
              ],
            ),
            body:
            session==null?Container(child: Text("Please login"),): GetBuilder<WishListController>(builder: (wishListControlller) {
              if (wishListControlller.lodaer) {
                return Container();
              } else {
                return RefreshIndicator(
                  onRefresh: () async{
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      wishListControlller.getWishList();
                    });
                  },
                  child: Container(
                    width: width,
                    height: height,
                    child: SizedBox(
                      width: width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: wishListControlller
                              .wihlistlpojo.value.staffDetail!.length,
                          itemBuilder: (context, position) {
                            return wishlist(
                                context,
                                width,
                                height,
                                wishListControlller
                                    .wihlistlpojo.value.staffDetail![position]);
                          }),
                    ),
                  ),
                );
              }
            })));
  }

  Widget wishlist(
      BuildContext context, width, height, StaffDetail staffDetail) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SaloonDetail(staffDetail.shopId!)),
        );
      },
      child: Container(
        width: width,
        height: height * 0.2,
        margin: EdgeInsets.only(top: height * 0.001, bottom: height * 0.001),
        color: Colors.white,
        child: Card(
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Row(
                children: <Widget>[
                  /*TODO---Saloon image*/
                  Container(
                    child: Expanded(
                      flex: 3,
                      child: Container(
                          margin: EdgeInsets.only(left: 8),
                          height: MediaQuery.of(context).size.height * 0.2 -
                              height * 0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    staffDetail.shopLogo.toString()),
                                fit: BoxFit.cover,
                              ))),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(""),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: staffDetail.service!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            EdgeInsets.only(left: 4, right: 4),
                                        padding: EdgeInsets.all(4),
                                        color: Color(
                                            Utils.hexStringToHexInt('E5E5E5')),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  'images/svgicons/tagsvg.svg',
                                                  fit: BoxFit.contain,
                                                  width: 24,
                                                  height: 24,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 4),
                                              decoration: BoxDecoration(
                                                  color: Color(
                                                      Utils.hexStringToHexInt(
                                                          'E5E5E5'))),
                                              child: Center(
                                                  child: Text(
                                                staffDetail.service![index]
                                                    .serviceTitle
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: width * 0.03),
                                              )),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: height * 0.01),
                                child: RatingBarIndicator(
                                  rating: 2.75,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 18.0,
                                  direction: Axis.horizontal,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                        flex: 1,
                        child: Container(
                          child: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 34,
                            color: Colors.blue,
                          ),
                        )),
                  )
                ],
              ),
              // /*TODO--femina text*/
              Positioned(
                top: height * 0.02,
                left: width * 0.3 + width * 0.03,
                child: Text(
                  staffDetail.shopName.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontFamily: 'Poppins Regular'),
                ),
              ),

              /*TODO---address*/
              Positioned(
                top: height * 0.05,
                left: width * 0.3 + width * 0.03,
                child: Text(
                  staffDetail.location.toString(),
                  style: TextStyle(
                      color: Color(Utils.hexStringToHexInt('A3A2A2')),
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontFamily: 'Poppins Regular'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
