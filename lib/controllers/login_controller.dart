import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:v2/apis.dart';

class LoginController extends GetxController {
  var loginResponse = ''.obs;
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var successRequest = false.obs;
  GetStorage box = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  void clearValues() {
    isLoading.value = false;
    isSuccess.value = false;
    successRequest.value = false;
    loginResponse.value = '';
  }

  void postLogin(String email, String password, String userType) async {
    isLoading.value = true;
    String data = json
        .encode({'email': email, 'password': password, 'user_type': userType, 'player_id': '29423jdf'});
    final response = await http.post(Uri.parse(SIGN_IN_API), body: data);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      isSuccess.value = res['success'];
      if (isSuccess.value) {
        loginResponse.value = res['message'];
        box.write('user_id', res['user_id']);
        box.write('role_id', res['role_id']);
      } else {
        loginResponse.value = res['message'];
      }
      successRequest.value = true;
      print(response.body);
    } else {
      successRequest.value = true;
      loginResponse.value = 'There is server error';
    }
    isLoading.value = false;
  }
}
