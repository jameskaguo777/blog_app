import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:v2/apis.dart';
import 'package:v2/constants/new_api.dart';
import 'package:v2/controllers/check_token_controller.dart';
import 'package:v2/tools/device_info.dart';

class LoginController extends GetxController {
  var loginResponse = ''.obs;
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var successRequest = false.obs;
  GetStorage box = GetStorage();
  CheckTokenController _checkTokenController = Get.find();
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
    String deviceName = await DeviceInfo().getDeviceInfo();
    String data = json.encode(
        {'username': email, 'password': password, 'device_name': deviceName});
    final response = await http.post(Uri.parse(LOGIN), body: data, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      isSuccess.value = res['message']['success'];
      if (isSuccess.value) {
        print('is success value ${isSuccess.value}');
        loginResponse.value = res['message']['message'];
        await box.write('access_token', res['access_token']);
        await box.write('test', 'tumelewa');
        // box.write('role_id', res['role_id']);
        print('token ${res['access_token']}');
        // _checkTokenController.getTokenF();
      } else {
        loginResponse.value = res['message']['message'];
      }
      successRequest.value = true;
    } else {
      successRequest.value = true;
      loginResponse.value = 'There is server error';
    }
    isLoading.value = false;
  }
}
