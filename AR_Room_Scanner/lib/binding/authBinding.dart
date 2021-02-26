import 'package:ar_sketcher/controllers/authController.dart';
import 'package:ar_sketcher/controllers/floorplanController.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
  }

}