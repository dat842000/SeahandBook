import 'package:get/get.dart';
import 'package:sea_handbook/api/api.dart';
import 'dashboard.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ApiProvider());
    Get.put(DashboardController(apiRepository: Get.find()));
  }
}
