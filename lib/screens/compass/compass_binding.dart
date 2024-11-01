import 'package:get/get.dart';
import 'compass.dart';

class CompassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompassController());
  }
}