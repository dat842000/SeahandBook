import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sea_handbook/models/hierarchy_item.dart';
import 'package:sea_handbook/routes/app_pages.dart';
import 'package:sea_handbook/shared/widgets/action_button.dart';
import 'package:sea_handbook/shared/widgets/expandable_fab.dart';
import 'dashboard.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  static const images = [
    'assets/images/ship.png',
    'assets/images/meteorology.png',
    'assets/images/compass.png',
    'assets/images/heart.png',
    'assets/images/worker.png',
    'assets/images/flag.png',
    'assets/images/gear.png',
    'assets/images/reef-knot.png',
    'assets/images/worldwide.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ExpandableFab(children: [
          ActionButton(
            icon: Image.asset("assets/images/aiChat.png", width: 50),
            onPressed: () {
              Get.toNamed(Routes.CHATBOX);
            },
          ),
          ActionButton(
            icon: Image.asset("assets/images/compassIcon.png", width: 50),
            onPressed: () {
              Get.toNamed(Routes.COMPASS);
            },
          ),
        ], distance: 60),
        backgroundColor: Colors.black,
        body: mainChapters());
  }

  Widget mainChapters() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildAppBar(),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: Get.width * 6 / 7,
            height: Get.height - 30 - 50 - Get.height / 5,
            child: controller.obx(
              (state) => Obx(
                () => SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: controller.onReFresh,
                  onLoading: controller.onLoading,
                  controller: controller.refreshController,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 50),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.dataHierarchy.length,
                      itemBuilder: (context, index) =>
                          _item(controller.dataHierarchy[index], index),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //   OnlyFloatingExample(),
        ],
      ),
    );
  }

  Widget _item(HierarchyItem chapter, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed("/subCategory/${chapter.key}");
      },
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: SizedBox(
        height: 100,
        width: Get.width * 5 / 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        chapter.title,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Words",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    )
                  ],
                )
              ],
            ),
            const Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.TOOLPAGE);
      },
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: const Color(0xffe0e7f3).withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: const Center(
            child: Icon(
              Icons.architecture,
              size: 30,
              color: Color(0xff5f79cf),
            ),
          )),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Knowledge\nis power',
                style: TextStyle(
                  fontSize: 30,
                  height: 1.5,
                  color: Color(0xff3a4e97),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              return Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image.asset(
                  fit: BoxFit.cover,
                  'assets/images/dashboard_background.png',
                  width: availableWidth,
                  height: Get.height / 5,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
