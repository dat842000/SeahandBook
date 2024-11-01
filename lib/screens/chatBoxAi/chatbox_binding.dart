import 'package:get/get.dart';
import 'package:sea_handbook/screens/chatBoxAi/chatbox.dart';


class ChatBoxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatBoxController());
  }
}