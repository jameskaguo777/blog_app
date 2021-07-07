import 'package:get/get.dart';
import 'package:v2/constants/new_api.dart';
import 'package:v2/controllers/check_token_controller.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthonticationController extends GetxController {
  String token;
  CheckTokenController _checkTokenController = Get.find();
  var isAuthorized = true.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    token = _checkTokenController.token.value;
    checkAuth();
  }

  void checkAuth() async {
    isLoading.value = true;

    final response = await http.get(Uri.parse(AUTHORIZED), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      var authorized = jsonDecode(response.body);
      if (authorized == 1) {
        print('auth imepita');
        isAuthorized.value = true;
        print(isAuthorized.value);
      }
    }
    isAuthorized.value = false;
    isLoading.value = false;
  }
}