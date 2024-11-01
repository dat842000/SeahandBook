import 'dart:convert';
import 'package:sea_handbook/models/page.dart';
import 'package:sea_handbook/models/page_hierarchy.dart';
import 'api_provider.dart';

class CustomException implements Exception {}

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;
  Future<List<Page>> getPages() async {
    final res = await apiProvider.getPages('pages');
    if (res.isOk) {
      var data = json.decode(res.bodyString!);
      return (data as List).map((e) => Page.fromJson(e)).toList();
    } else if (res.statusCode == 404) {
      throw CustomException();
    }
    throw Exception("Fail get campaign");
  }
  Future<PageHierarchy> getHierarchy() async {
    final res = await apiProvider.getPages('hierarchy');
    if (res.isOk) {
      var data = json.decode(res.bodyString!);
      return PageHierarchy.fromJson(data[0]);
    } else if (res.statusCode == 404) {
      throw CustomException();
    }
    throw Exception("Fail get campaign");
  }

}
