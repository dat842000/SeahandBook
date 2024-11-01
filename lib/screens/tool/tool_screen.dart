import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'tool.dart';

class ToolScreen extends GetView<ToolController> {
  const ToolScreen({Key? key}) : super(key: key);

  static const options = [
    'Mass',
    'Speed',
    'Pressure',
    'Length',
    'Volume',
  ];

  static const tools = [
    'Converter',
    'Calculator',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffdfeafb),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 50, bottom: 30, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: _backButton(
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Color(0xff5f79cf),
                          ),
                        ),
                        const Color(0xffe0e7f3)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              width: Get.width,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: tools.length,
                itemBuilder: (context, index) => _option(tools[index]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            _changeConverter(),
            const SizedBox(
              height: 10,
            ),
            _converter(),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }

  Widget _option(option) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.chosenTool(option);
        },
        child: Container(
          width: 80,
          height: 40,
          margin: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
          decoration: BoxDecoration(
            color: option == controller.chosenTool.value
                ? Colors.white
                : Colors.white60,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: option == controller.chosenTool.value
                ? const [
                    BoxShadow(
                        color: Color(0xff98989d),
                        blurRadius: 5.0,
                        offset: Offset(1, 1)),
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 5.0,
                        offset: Offset(-1, -1)),
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 0.0,
                        offset: Offset(1, -1)),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              option,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  Widget _changeConverter() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(
            left: 30.0, top: 10, right: 30, bottom: 0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xff98989d),
                    blurRadius: 5.0,
                    offset: Offset(1, 1)),
                BoxShadow(
                    color: Colors.white,
                    blurRadius: 5.0,
                    offset: Offset(-1, -1)),
                BoxShadow(
                    color: Colors.white,
                    blurRadius: 0.0,
                    offset: Offset(1, -1)),
              ]),
          child: DropdownButtonFormField(
              isExpanded: true,
              isDense: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                  // borderRadius: BorderRadius.circular(2),
                  // borderSide: const BorderSide(
                  //   color: Colors.black12,
                  //   width: 2,
                  // ),
                ),
                // focusedBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(2),
                //   borderSide: BorderSide.none,
                // ),
              ),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  child: Text(option),
                  value: option,
                );
              }).toList(),
              value: controller.chosenOption.value,
              onChanged: (value) {
                controller.changeConverter(value);
              }),
        ),
      ),
    );
  }

  Widget _converter() {
    return Obx(() => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 5, right: 30, bottom: 0),
              child: Container(
                padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xff98989d),
                          blurRadius: 5.0,
                          offset: Offset(1, 1)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 5.0,
                          offset: Offset(-1, -1)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 0.0,
                          offset: Offset(1, -1)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      ('From'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        // Text('23', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),

                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          // decoration: const BoxDecoration(
                          //     color: Color(0xffF3F3F3),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(8.0))),
                          width: Get.width * 5 / 6 * 0.5,
                          child: TextField(
                            onChanged: (value) {
                              controller.onChange(value, "from");
                            },
                            controller: controller.fromController,
                            enableInteractiveSelection: true,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xfff00000),
                                ),
                              ),
                              contentPadding: EdgeInsets.only(left: 18.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: controller.options.value.keys
                                  .toList()
                                  .map((String option) {
                                return DropdownMenuItem<String>(
                                  child: Text(option),
                                  value: option,
                                );
                              }).toList(),
                              value: controller.fromOption.value,
                              onChanged: (value) {
                                controller.changeRates(value, "from");
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 20, right: 30, bottom: 15),
              child: Container(
                padding: const EdgeInsets.only(right: 0, left: 15.0, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xff98989d),
                          blurRadius: 5.0,
                          offset: Offset(1, 1)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 5.0,
                          offset: Offset(-1, -1)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 0.0,
                          offset: Offset(1, -1)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      ('To'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        // const Text('23000', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          // decoration: const BoxDecoration(
                          //     color: Color(0xffF3F3F3),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(8.0))),
                          width: Get.width * 5 / 6 * 0.5,
                          child: TextField(
                            controller: controller.toController,
                            onChanged: (value) {
                              controller.onChange(value, "to");
                            },
                            // keyboardType: TextInputType.number,
                            keyboardType: TextInputType.number,
                            // inputFormatters: <TextInputFormatter>[
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
                            decoration: const InputDecoration(
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: Color(0xfff00000),
                              //   ),
                              // ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xfff00000),
                                ),
                              ),

                              contentPadding: EdgeInsets.only(left: 18.0),
                            ),
                          ),
                        ),

                        Expanded(
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(2),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: controller.options.value.keys
                                  .toList()
                                  .map((String option) {
                                return DropdownMenuItem<String>(
                                  child: Text(option),
                                  value: option,
                                );
                              }).toList(),
                              value: controller.toOption.value,
                              onChanged: (value) {
                                controller.changeRates(value, "to");
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _backButton(Widget icon, Color color) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(child: icon),
    );
  }
}
