import 'dart:ui';

import 'package:ar_sketcher/models/floorplan.dart';
import 'package:ar_sketcher/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel userModel) async {
    try {
      await _firestore.collection("users").doc(userModel.id).set({
        "name": userModel.name,
        "email": userModel.email,
      });
      _firestore
          .collection("users")
          .doc(userModel.id)
          .collection("floorplans")
          .doc()
          .set({
        "name": "Project Example",
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateName(String uid, String name, String collection) async {
    _firestore.collection(collection).doc(uid).update({"name": name}).then((_) {
      print("success!");
    });
  }

  Future<void> updateFloorName(String uid, String name, String floorId) async {
    _firestore
        .collection("users")
        .doc(uid)
        .collection("floorplans")
        .doc(floorId)
        .update({"name": name}).then((_) {
      print("success!");
    });
  }

  Future<void> delete(String uid) {
    return _firestore.collection("users").doc(uid).delete();
  }

  Future<void> deleteFloorPlan(String uid, String floorId) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("floorplans")
        .doc(floorId)
        .delete();
  }

  Future<bool> createFloorPlan(
      FloorPlanModel floorPlanModel, String uid) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("floorplans")
          .doc()
          .set({
        "name": floorPlanModel.name,
        "offsets": floorPlanModel.offsets,
        "midpoints": floorPlanModel.midPoints,
        "distanceString": floorPlanModel.distanceString,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<FloorPlanModel> getFloorPlan(String floorId, String uid) async {
    try {
      DocumentSnapshot _doc = await _firestore
          .collection("users")
          .doc(uid)
          .collection("floorplans")
          .doc(floorId)
          .get();
      return FloorPlanModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Future<void> updateFloorPlan(String uid, String floorId, List<Offset>_offsets, List<Offset>_midPoints, List<String>_distanceStrings)async{
  //   _firestore.collection("users").doc(uid).collection("floorplans").doc(floorId).update({
  //     "distanceString": _distanceStrings,
  //     "offsets": _offsets,
  //     "midpoints":_midPoints,
  //   }).then((_){
  //     print("success!");
  //   });
  // }

}
