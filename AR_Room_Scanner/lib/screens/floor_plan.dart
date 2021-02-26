import 'dart:ui';
import 'dart:async';
import 'package:ar_sketcher/components_ui/rounded_btn.dart';
import 'package:ar_sketcher/components_ui/rounded_input.dart';
import 'package:ar_sketcher/controllers/authController.dart';
import 'package:ar_sketcher/controllers/floorplanController.dart';
import 'package:ar_sketcher/screens/detail_page.dart';
import 'package:ar_sketcher/screens/home_page.dart';
import 'package:ar_sketcher/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//To get measurements to create floor plan.
import 'marker_object.dart';
import 'package:get/get.dart';


class FloorPlan extends GetWidget<FloorPlanController> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Get.dialog(
        AlertDialog(
          title: new Text('Warning'),
          content: new Text('Do you want to go back?'),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Get.find<FloorPlanController>().clear();
                      Navigator.of(context).pop(true);
                      Get.off(HomePage());
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ],
        ),
      ) ??
          false;
    }
    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection("users")
    //       .doc(Get.find<AuthController>().user.uid)
    //       .collection("floorplans")
    //       .snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasError) return new Text('${snapshot.error}');
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.waiting:
    //           return new Center(child: new CircularProgressIndicator());
    //         case ConnectionState.active:
              return WillPopScope(
                onWillPop: _onBackPressed,
                child: Scaffold(
                    resizeToAvoidBottomInset: false,

                    body: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 25),
                        child: FlatButton(
                            color: Color(0xff1761a0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            onPressed: () {
                              //Add function
                              Get.dialog(AlertDialog(
                                  title: Text('Warning'),
                                  actions: [
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              //add functionality
                                              // controller.updateFloorPlan(
                                              //     Get.find<FloorPlanController>()
                                              //         .floorplan
                                              //         .id,
                                              //     distanceString,
                                              //     null,
                                              //     null);
                                              Get.find<FloorPlanController>()
                                                  .clear();
                                              Get.off(HomePage());
                                            },
                                            child: Text('OK')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('CANCEL'))
                                      ],
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                    ),
                                  ],
                                  content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text(
                                              'You are about to leave the project. All changes will be save.')
                                        ],
                                      ))));
                            },
                            child: Text(
                              'Exit',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 45),
                        child: Container(
                          //color: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 25),
                            child: LayoutBuilder(
                                builder: (_, constraints) =>
                                    Container(
                                      width: constraints
                                          .widthConstraints()
                                          .maxWidth,
                                      height: constraints
                                          .heightConstraints()
                                          .maxHeight,
                                      color: Colors.white,
                                      child: /*Center(child:Column(children: [*/
                                      RepaintBoundary(
                                        child: CustomPaint(
                                            painter: BluePrintPainter()),
                                      ),
                                    ))),
                      ),
                    ]),
                    bottomNavigationBar: Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, left: 10.0, bottom: 25.0, top: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          height: 115,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  MaterialButton(
                                      onPressed: () {
                                        Get.dialog(SimpleDialog(
                                          children: [
                                        //     Obx( ()  {
                                        //       print(' floorpantName ${controller.floorplanName}');
                                        //     return TextFormField( onChanged: (v) => { },
                                        //       decoration: InputDecoration(labelText: "name"),
                                        //
                                        // );}),

                                            RoundedInputField(
                                                controller: nameController,
                                                hintText: "name")
                                                .paddingOnly(
                                                left: 20.0,
                                                right: 20.0,
                                                top: 10.0),
                                            RoundedButton(
                                              color: Color(0xff1761a0),
                                              textColor: Colors.white,
                                              text: "OK",
                                              press: () {
                                                controller.changeFloorName(
                                                    nameController.text,
                                                    controller.floorplan.id);
                                                Navigator.of(context).pop();
                                              },
                                            ).paddingOnly(
                                                left: 20.0,
                                                right: 20.0,
                                                bottom: 10.0)
                                          ],
                                        ));
                                      },
                                      child:  Obx( () =>
                                      Text(
                                        controller.floorplanName == null
                                            ? "name"
                                            : controller.floorplanName.toString(),
                                        style: TextStyle(color: Colors.black),
                                      ))

                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(() => DetailPage());
                                      },
                                      child: Text(
                                        'details',
                                        style: TextStyle(
                                            color: Color(0xff1761a0)),
                                      ))
                                ],
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                              ),
                              Row(
                                //TODO: By clicking any of the options clears the canvas !!!!!!
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,

                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 40.0),
                                          child: Column(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add_circle,
                                                  color: Color(0xff1761a0),
                                                ),
                                                onPressed: () {
                                                  //Add function
                                                },
                                              ),
                                              Text('Add Object',
                                                  style:
                                                  TextStyle(
                                                      color: Color(0xff1761a0)))
                                            ],
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon:
                                        Icon(
                                            Icons.block_flipped,
                                            color: Colors.red),
                                        onPressed: () {
                                          //Add function
                                          Get.dialog(AlertDialog(
                                              title: Text('Warning'),
                                              actions: [
                                                Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          //add functionality
                                                        },
                                                        child: Text('OK')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('CANCEL'))
                                                  ],
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                ),
                                              ],
                                              content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      Text(
                                                          'All changes will be delete it.\nWould you like to proceed?')
                                                    ],
                                                  ))));
                                        },
                                      ),
                                      Text('Cancel',
                                          style: TextStyle(color: Colors
                                              .red))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 55.0),
                                        child: Column(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.undo,
                                                  color: Color(0xff1761a0)),
                                              onPressed: () {
                                                //Add function
                                                Get.dialog(AlertDialog(
                                                    title: Text('Warning'),
                                                    actions: [
                                                      Row(
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                //add functionality
                                                              },
                                                              child: Text(
                                                                  'OK')),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  'CANCEL'))
                                                        ],
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                      ),
                                                    ],
                                                    content: SingleChildScrollView(
                                                        child: ListBody(
                                                          children: [
                                                            Text(
                                                                'Last change will be delete it.\nWould you like to proceed?')
                                                          ],
                                                        ))));
                                              },
                                            ),
                                            Text('Undo',
                                                style:
                                                TextStyle(
                                                    color: Color(0xff1761a0)))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))),
              );
            // default:
            //   return Text("default");
          }
        // });
  // }
}

class BluePrintPainter extends CustomPainter {
  String name;
  BluePrintPainter({this.name});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.black;

    final dotPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.blue;

    final style = TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        fontSize: 20.0);

    if (Get.arguments != null) {
      offsets = Get.find<FloorPlanController>().floorplan.offsetsAsOffsets();
      distanceString = Get.find<FloorPlanController>().floorplan.distanceString;
      midPoints =
          Get.find<FloorPlanController>().floorplan.midPointsAsOffsets();
    }

    int leng = offsets?.length;
    //check if max or min are past edge with scaler if so scaler -1 and retry.
    double scaler = 200.0;
    if (maxXSize * 5 > size.width || maxZSize * 5 > size.height) {
      //if the size at min is to big it kicks your out.
      print('ERROR: BluePrint to big.');
      Get.to(MarkerObject());
    }
    while (maxXSize * scaler > size.width || maxZSize * scaler > size.height) {
      //could split into two loops if problems occur.
      scaler -= 1.0;
    }

    double tempdx = 0;
    double tempdy = 0;
    for (int i = 0; i < leng; i++) {
      tempdx = offsets[i].dx * scaler;
      tempdy = offsets[i].dy * scaler;
      offsets[i] = Offset(tempdx, tempdy );
    }

    for (int i = 0; i < midPoints.length; i++) {
      tempdx = midPoints[i].dx * scaler;
      tempdy = midPoints[i].dy * scaler;
      midPoints[i] = Offset(tempdx, tempdy );
    }

    //lastPoss
    if (leng > 1) {
      for (int i = 1; i < leng; i++) {
        canvas.drawLine(offsets[i - 1], offsets[i], paint);
      }
      canvas.drawLine(offsets[leng - 1], offsets[0], paint);
    }

    //text painter
    for (int i = 0; i < midPoints.length; i++) {
      final TextPainter textPainter = TextPainter(
          text: TextSpan(text: distanceString[i], style: style),
          textAlign: TextAlign.justify,
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: size.width - 20);
      textPainter.paint(canvas, midPoints[i]);
    }

    canvas.drawPoints(PointMode.points, offsets, dotPaint);

    //save canvas to a temp area and on save it edits file name and stuff for database collection.
    //canvas.save();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate)=> true;
}
