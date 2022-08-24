import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_caroselController.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  ProfileCOntroller profileController = Get.put(ProfileCOntroller());
  var tempArray = [];
  var dropdownvalue = "";

  @override
  Widget build(BuildContext context) {
    var data = profileController.adminServicePojo.value.serviceDetail;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Container(
      width: width,
      height: height,
      color: Colors.white,
      child:

      GetBuilder<ProfileCOntroller>(builder: (profileController) {
        return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[

          Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data!.length,
                itemBuilder: (context, position) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data[position].serviceTitle.toString(),
                            style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Poppins Black',
                                color: Colors.black),
                          ),
                          Container(
                            margin: EdgeInsets.all(4.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data[position].services!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[position]
                                                  .services![index]
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  fontFamily: 'Poppins Regular',
                                                  color: Colors.black),
                                            ),
                                            Text(
                                                data[position]
                                                    .services![index]
                                                    .price
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 10.0,
                                                    fontFamily: 'Poppins Regular',
                                                    color: Colors.black)),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (tempArray.contains(
                                                  data[position]
                                                      .services![index]
                                                      .name)) {
                                                tempArray.remove(data[position]
                                                    .services![index]
                                                    .name);
                                              } else {
                                                tempArray.add(data[position]
                                                    .services![index]
                                                    .name);
                                              }

                                              print(tempArray);
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(tempArray.contains(
                                                data[position]
                                                    .services![index]
                                                    .name)
                                                ? "Remove"
                                                : "Add"),
                                            decoration: BoxDecoration(
                                                color: Colors.cyan,
                                                borderRadius:
                                                BorderRadius.circular(12.0)),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ]);
      })

    ));
  }
}
