import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:v2/apis.dart';
import 'package:v2/constants/new_api.dart';
import 'package:v2/tools/device_info.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  var signUpResponse = ''.obs;
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
    signUpResponse.value = '';
  }

  void signUp(String fullName, String email, String phone, String password, String userType,
      {String activationCode='null'}) async {
        String deviceName = await DeviceInfo().getDeviceInfo();
    isLoading.value = true;
    String data = jsonEncode({
      'name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'activation_code': activationCode,
      'type': userType,
      'device_name': deviceName
    });
    final response = await http.post(Uri.parse(REGISTER), body: data, headers: {
      'Content-Type': 'application/json',
    });
    print(response.body);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      
      isSuccess.value = res['message']['success'];
      successRequest.value = true;
      if (isSuccess.value) {
        box.write('access_token', res['access_token']);
        successRequest.value = true;
      } else{
        signUpResponse.value = res['message']['message'];
      }
      isLoading.value = false;
    }
  }
}
