import 'package:ar_sketcher/controllers/authController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends GetWidget<AuthController> {
  final maxline = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Details", style: TextStyle(color: Color(0xff1761a0))),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff1761a0),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Card(
                margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                elevation: 3.0,
                child: ListView(shrinkWrap: true, children: [
                  ListTile(
                    title: Text(
                      'Ground Floor',
                      textScaleFactor: 1.25,
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 1.0, right: 1.0, top: 8.0, bottom: 16.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Surface\nPerimeter\nVolume',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                          Column(
                            children: [
                              Text("196 sq ft\n56' 1 1/2\"\n1624 ft3",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.right),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                          Column(
                            children: [
                              Text('Rooms\nDoors\nWindows',
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.left),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                          Column(
                            children: [
                              Text('1\n111\n0',
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.right),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                        ],
                      )
                    ]),
                  )
                ])),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            ListTile(
              title: Text(
                'MEASURES',
                textScaleFactor: 1.15,
                style: TextStyle(color: Colors.black38),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 0, right: 0, top: 0),
              elevation: 3.0,
              child: ListTile(
                title: Text(
                  'Ceiling Height',
                  textScaleFactor: 1.25,
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Text(
                  "8'",
                  textScaleFactor: 1.25,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            ListTile(
              title: Text(
                'NOTES',
                textScaleFactor: 1.15,
                style: TextStyle(color: Colors.black38),
              ),
            ),
            Card(
                margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                elevation: 3.0,
                child: Container(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: maxline,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type something..."),
                  ),
                ))
          ]),
        ));
  }
}
