import 'package:get/get.dart';
import 'package:sea_handbook/screens/dashboard/dashboard.dart';
import 'sub_category.dart';

class SubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubCategoryController(),tag: Get.parameters["id"]);
    Get.put(DashboardController(apiRepository: Get.find()));
  }
}