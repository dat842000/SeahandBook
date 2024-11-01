import 'package:get/get.dart';


import 'base_provider.dart';

class ApiProvider extends BaseProvider {
  Future<Response> getPages(String path) {
    return get(path);
  }
  Future<Response> getHierarchy(String path) {
    return get(path);
  }
}
