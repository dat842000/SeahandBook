import 'dart:async';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sea_handbook/api/api.dart';
import 'package:sea_handbook/models/hierarchy_item.dart';
import 'package:sea_handbook/models/page.dart';
import 'package:sea_handbook/models/page_hierarchy.dart';

class DashboardController extends GetxController
    with StateMixin<List<HierarchyItem>> {
  DashboardController({required this.apiRepository});

  final ApiRepository apiRepository;

  late RefreshController refreshController;

  final dataHierarchy = RxList<HierarchyItem>([]);
  final listPage = RxList<Page>([]);
  var hasFocus = Rx<bool>(false);


  void onReFresh() async {
    await _readData();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await _readData();
    refreshController.loadComplete();
  }

  Future<void> _readData() async {
    var futures = [
      apiRepository.getPages(),
      apiRepository.getHierarchy(),
    ];

    // Wait for both futures to complete
    var results = await Future.wait(futures);
    listPage(results[0] as List<Page>);
    dataHierarchy((results[1] as PageHierarchy).hierarchy);
    change(dataHierarchy, status: RxStatus.success());
  }

  Page? getChapter() {
    var id = getCurrentHierarchyItem()?.id;
    // print(listPage);
    if (id == null) return null;
    var result = listPage.firstWhere((element) => element.id == id);

    return result;
  }

  HierarchyItem? getCurrentHierarchyItem() {
    var id = Get.parameters['id'];
    var listPath = id?.split(".");
    // print(listPath);
    if (listPath == null) return null;
    var findHierarchyItem = dataHierarchy.firstWhere((element) =>
    element.key.split(".")[1] == listPath[1]);
    if (listPath.length != 2) {
      for (var i = 2; i < listPath.length; i++) {
        findHierarchyItem =
            findHierarchyItem.children.firstWhere((element) => element.key.split(".")[i] ==
                listPath[i]);
      }
    }
    return findHierarchyItem;
  }

  @override
  void onInit() {
    _readData();
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
