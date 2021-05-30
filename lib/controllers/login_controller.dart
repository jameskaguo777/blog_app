import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:v2/apis.dart';

class LoginController extends GetxController {
  var loginResponse = ''.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void postLogin(String email, String password) async {
    isLoading.value = true;
    String data = json.encode({'email': email, 'password': password});
    final response = await http.post(Uri.parse(SIGN_IN_API), body: data);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      loginResponse.value = res['message'];
      print(response.body);
    } else {}
    isLoading.value = false;
  }
}
