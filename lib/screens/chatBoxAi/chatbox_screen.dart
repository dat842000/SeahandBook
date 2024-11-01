import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_handbook/screens/chatBoxAi/chatbox.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatBoxScreen extends GetView<ChatBoxController> {
  const ChatBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Gemini Chat",
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Obx(() =>DashChat(
          inputOptions: InputOptions(trailing: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.image,
              ),
            )
          ]),
          key: GlobalKey(),
          currentUser: controller.currentUser,
          onSend: controller.sendMessage,
          messages: controller.messages.value,
        ));
  }
}
