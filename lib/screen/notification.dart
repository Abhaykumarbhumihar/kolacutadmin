import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolacur_admin/controller/dashboard_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Utils.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Color(Utils.hexStringToHexInt('46D0D9')),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.keyboard_backspace_rounded,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Notification',
                style: TextStyle(
                    fontFamily: 'Poppins Regular',
                    color: Colors.white,
                    fontSize: width * 0.04),
              ),
            ),
            body: SizedBox(
                width: width,
                child: Center(
                    child: Container(
                        width: width,
                        height: height,
                        child: GetBuilder<DashboardController>(
                            builder: (homecontroller) {
                          if (homecontroller.lodaer) {
                            return Container();
                          } else {
                            return ListView.builder(
                                itemCount: homecontroller.notification.value
                                    .notificationDetail?.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 2.0,
                                        bottom: 2.0),
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(6.0),
                                        margin: EdgeInsets.all(4.0),
                                        width: width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "${homecontroller.notification.value.notificationDetail?[position].title}",
                                                  style:
                                                      TextStyle(fontSize: 12.0),
                                                ),
                                                SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text(
                                                  "${homecontroller.notification.value.notificationDetail?[position].description}",
                                                  style:
                                                      TextStyle(fontSize: 10.0),
                                                ),
                                              ],
                                            ),
                                            // Text(
                                            //   "11:AM",
                                            //   style: TextStyle(fontSize: 8.0),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }))))));
  }
}
