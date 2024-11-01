import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:sea_handbook/screens/dashboard/dashboard.dart';
import 'package:sea_handbook/shared/utils/HtmlUtils.dart';

class SubCategoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DashboardController dashboardController = Get.find();
  final showSearchBar = RxBool(false);
  final searchValue = RxString("");
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late FindInteractionController findInteractionController;
  InAppWebViewSettings settings = InAppWebViewSettings();
  late InAppWebViewController inAppWebViewController;


  String getHTMLContent() {
    return HtmlUtils.generateHtmlDocument(
      dashboardController.getChapter()?.content,
      customStyleCssTag: dashboardController.getChapter()?.css,
    );
  }

  void closeSearchBar () {
    print("1");
    findInteractionController.clearMatches();
    searchValue('');
    showSearchBar(false);
  }

  void onSubmited (String? id, String value) {
    // print("2");
    // FindInteractionController findInteractionController = Get.find(tag: id);
    if (value == '') {
      findInteractionController.clearMatches();
      searchValue('');
    } else {
      findInteractionController.findAll(find: value);
    }
  }

  FindInteractionController initialFindController(String? id) {
    // settings = InAppWebViewSettings();
    // settings.isFindInteractionEnabled = true;
    // var findInteractionController = Get.find<FindInteractionController>(tag: id);
    // if(findInteractionController != null){
    //   Get.delete(tag: id,force: true);
    // }
    findInteractionController = Get.put(FindInteractionController(

      onFindResultReceived: (controller, activeMatchOrdinal, numberOfMatches,
          isDoneCounting) async {
        if (isDoneCounting) {
          searchValue.value = numberOfMatches > 0
              ? '${activeMatchOrdinal + 1} of $numberOfMatches'
              : '';
          if (numberOfMatches == 0) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text(
                  'No matches found for "${await controller.getSearchText()}"'),
            ));
          }
        }
      },
    ));
    return findInteractionController;
  }

  @override
  void onInit() {
    super.onInit();
    initialFindController(Get.parameters["id"]);
  }

  @override
  void dispose() {
    // close the webview here
    super.dispose();
  }
}
