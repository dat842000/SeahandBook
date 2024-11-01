import 'package:get/get.dart';
import 'package:sea_handbook/screens/chatBoxAi/chatbox.dart';
import 'package:sea_handbook/screens/compass/compass.dart';
import 'package:sea_handbook/screens/dashboard/dashboard.dart';
import 'package:sea_handbook/screens/subCategory/sub_category.dart';
import 'package:sea_handbook/screens/tool/tool.dart';

part 'app_routes.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.SUBCATEGORY,
      page: () => SubCategoryScreen(),
      binding: SubCategoryBinding(),
    ),
    GetPage(
      name: Routes.TOOLPAGE,
      page: () => const ToolScreen(),
      binding: ToolBinding(),
    ),
    GetPage(
      name: Routes.COMPASS,
      transition: Transition.cupertinoDialog,
      page: () => const CompassScreen(),
      binding: CompassBinding(),
    ),
    GetPage(
      name: Routes.CHATBOX,
      transition: Transition.cupertinoDialog,
      page: () => const ChatBoxScreen(),
      binding: ChatBoxBinding(),
    ),
  ];
}
