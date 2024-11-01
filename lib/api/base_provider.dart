import 'package:get/get.dart';

import 'api.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    print(String.fromEnvironment("API_URL"));
    httpClient.baseUrl = "http://localhost:4000/";
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.errorSafety = false;
    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == null) {
        throw Exception("Network Connection Error");
      }
      return response;
    });
  }
}
