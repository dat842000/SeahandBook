import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sea_handbook/routes/app_pages.dart';
import 'compass.dart';

class CompassScreen extends GetView<CompassController> {
  const CompassScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.back();
            },
            backgroundColor: Colors.white,
            child: Image.asset('assets/images/compassIcon.png')),
      backgroundColor: const Color(0xff4a4a4a),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${controller.heading.value.ceil().toString()}°",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 50,),
            Padding(padding: const EdgeInsets.all(18),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/cadrant.png'),
                  Transform.rotate(angle: ((controller.heading.value ?? 0) * (pi/180) *-1),
                    child: Image.asset('assets/images/pointer.png', scale: 1.1,),
                  ),
                ],
              ),
            )
          ],
        )
      );

  }
}
