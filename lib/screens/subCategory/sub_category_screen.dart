import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sea_handbook/models/hierarchy_item.dart';
import 'package:sea_handbook/screens/dashboard/dashboard.dart';
import '../dashboard/dashboard_controller.dart';
import 'sub_category.dart';

class SubCategoryScreen extends GetView<SubCategoryController> {
  @override
  final String tag = Get.parameters["id"] ?? "";
  final DashboardController dashboardController = Get.find();

  SubCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: listChapters(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          String? id = Get.parameters["id"];
                          controller.closeSearchBar();
                          // FindInteractionController findInteractionController = Get.find(tag: Get.parameters["id"]);
                          // findInteractionController.dispose();
                          if (id != null) {
                            List<String> segments = id.split(".");
                            if (segments.length > 2) {
                              var preId = segments
                                  .sublist(0, segments.length - 1)
                                  .join(".");

                              // Get.offAndToNamed("/subCategory/$preId");
                            } else {
                              // Get.deleteAll();
                              // var subCategoryController = Get.find<SubCategoryController>(tag: tag); // Delete the controller
                              // subCategoryController.dispose();
                              // Get.offAllNamed("/");
                            }
                          }
                          Get.back();
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: _headerButton(const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Color(0xff5f79cf),
                          ),
                        )),
                      ),
                      _menuButton(context),
                    ],
                  ),
                ),
                Text(
                  dashboardController.getChapter()?.title ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800, height: 1.5),
                ),
                const SizedBox(
                  height: 5,
                ),
                ..._buildContent()
              ]),
            ),
          ),
          Obx(() => controller.showSearchBar.value
              ? _searchBar(context)
              : const SizedBox())
        ],
      ),
    );
  }

  Drawer listChapters() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Sub Chapters",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() =>
                dashboardController.getCurrentHierarchyItem()?.children != null
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dashboardController
                            .getCurrentHierarchyItem()
                            ?.children
                            .length,
                        itemBuilder: (context, index) => _item(
                            dashboardController
                                .getCurrentHierarchyItem()!
                                .children[index],
                            index + 1),
                      )
                    : const SizedBox())
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    var id = Get.parameters["id"];
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        child: Container(
          color: const Color(0xffd2d4da),
          height: MediaQuery.of(context).viewInsets.bottom == 0 ? 70 : 55,
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom == 0 ? 20 : 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  controller.closeSearchBar();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Color(0xffc4c8ce),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: TextField(
                    autocorrect: false,
                    textAlignVertical: TextAlignVertical.center,
                    onSubmitted: (value) async {
                      controller.onSubmited(id, value);
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, right: 10),
                        suffixText: controller.searchValue.value,
                        prefixIcon: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xffc4c8ce),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/svgs/search.svg',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide.none),
                        hintText: 'Find',
                        hintStyle: const TextStyle(color: Color(0xff9d9ea6))),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  print("4");
                  controller.findInteractionController.findNext(forward: false);
                },
                child: const RotatedBox(
                    quarterTurns: -45,
                    child: Icon(Icons.arrow_forward_ios_rounded)),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  print("3");
                  controller.findInteractionController.findNext();
                },
                child: const RotatedBox(
                    quarterTurns: 45,
                    child: Icon(Icons.arrow_forward_ios_rounded)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context) {
    if (dashboardController.getChapter() != null &&
        dashboardController.getChapter()?.content != "") {
      return _headerButton(PopupMenuButton(
        iconColor: const Color(0xff5f79cf),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              title: const Text("Menu"),
              onTap: () {
                Scaffold.of(context).openEndDrawer();
                Navigator.pop(context);
              },
              leading: const Icon(Icons.menu),
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: const Text("Search"),
              onTap: () {
                controller.showSearchBar(true);
                Navigator.pop(context);
              },
              leading: SvgPicture.asset(
                'assets/svgs/search.svg',
                color: Colors.black,
              ),
            ),
          )
        ],
      ));
    } else {
      return const SizedBox();
    }
  }

  List<Widget> _buildContent() {
    if (dashboardController.getChapter() != null &&
        dashboardController.getChapter()?.content != "") {
      return [
        Expanded(child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            return SizedBox(height: availableHeight, child: _paragraph());
          },
        )),
        const SizedBox(
          height: 20,
        )
      ];
    } else {
      return [
        Expanded(child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            return SizedBox(height: availableHeight, child: _subChapters());
          },
        ))
      ];
    }
  }

  Widget _subChapters() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              width: Get.width * 6 / 7,
              child: Obx(
                  () => dashboardController.getCurrentHierarchyItem() != null
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dashboardController
                              .getCurrentHierarchyItem()!
                              .children
                              .length,
                          itemBuilder: (context, index) => _item(
                              dashboardController
                                  .getCurrentHierarchyItem()!
                                  .children[index],
                              index + 1),
                        )
                      : const SizedBox())),
        ],
      ),
    );
  }

  Widget _item(HierarchyItem subChapter, int index) {
    return InkWell(
      onTap: () {
        controller.closeSearchBar();
        // Get.delete(tag: Get.parameters["id"]);
        Get.toNamed("/subCategory/${subChapter.key}");

      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 0.0, top: 0.0, right: 15),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: const Color(0xffd0d0d0))),
                    child: Center(child: Text(index.toString())),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 4 / 7,
                      child: Text(
                        subChapter.title,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paragraph() {
    return dashboardController.getChapter() != null &&
            dashboardController.getChapter()?.content != ""
        ? SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              width: Get.width - 30,
              child: InAppWebView(
                initialData:
                    InAppWebViewInitialData(data: controller.getHTMLContent()),
                onWebViewCreated: (webController) async {
                  controller.inAppWebViewController = webController;
                },
                initialSettings: controller.settings,

                findInteractionController: controller.findInteractionController,
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _headerButton(Widget icon) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: const Color(0xffe0e7f3).withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(child: icon),
    );
  }
}
