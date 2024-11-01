import 'dart:async';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(request) async {
  // final token = StorageService.box.pull(StorageItems.accessToken);
  // request.headers['X-Requested-With'] = 'XMLHttpRequest';
  // log(token!);
  // if(user != null) {
  //   request.headers['Authorization'] = 'Bearer $token';
  // }
  return request;
}