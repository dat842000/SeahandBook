import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';

class CompassController extends GetxController {
  final heading = RxDouble(0);


  @override
  void onInit() {
    super.onInit();
    FlutterCompass.events!.listen((event) {
      heading(event.heading);
    });
  }
}