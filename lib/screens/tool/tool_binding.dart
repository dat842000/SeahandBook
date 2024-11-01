import 'package:get/get.dart';
import 'package:sea_handbook/screens/tool/tool.dart';

class ToolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ToolController());
  }
}