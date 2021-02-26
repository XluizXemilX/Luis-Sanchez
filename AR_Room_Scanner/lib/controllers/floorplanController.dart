import 'dart:ui';

import 'package:ar_sketcher/controllers/authController.dart';
import 'package:ar_sketcher/services/database.dart';
import 'package:get/get.dart';
import 'package:ar_sketcher/models/floorplan.dart';

class FloorPlanController extends GetxController {
  Rx<FloorPlanModel> _floorplan = FloorPlanModel().obs;

  FloorPlanModel get floorplan => _floorplan.value;
  RxString get floorplanName => _floorplan.value.name.obs;

  set floorplan(FloorPlanModel value) => this._floorplan.value = value;

  Future<void> getFloorPlan(String floorId) async {
    _floorplan.value = await Database()
        .getFloorPlan(floorId, Get.find<AuthController>().user.uid);
  }

  void createFloorPlan(List<Offset> _offsets, List<String> _distanceStrings,
      List<Offset> _midPoints) async {
    try {
      FloorPlanModel _floorplan = FloorPlanModel(
          name: "name",
          midPoints: _midPoints.map((e) => this.offsetToMap(e)).toList(),
          distanceString: _distanceStrings,
          offsets: _offsets.map((e) => this.offsetToMap(e)).toList());
      if (await Database()
          .createFloorPlan(_floorplan, Get.find<AuthController>().user.uid)) {
        Get.find<FloorPlanController>().floorplan = _floorplan;
      }
    } catch (e) {}
  }

  void changeFloorName(String name, String floorId) async {
    Database()
        .updateFloorName(Get.find<AuthController>().user.uid, name, floorId);
    _floorplan.value.name = name;
    _floorplan.refresh();
  }

  Map<String, dynamic> offsetToMap(Offset offset) {
    return {'dx': offset.dx, 'dy': offset.dy};
  }

  void clear() {
    _floorplan.value = FloorPlanModel();
  }
}
