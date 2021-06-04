import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:v2/apis.dart';

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

  void signUp(String fullName, String email, String phone, String password,
      String address, String userType) async {
    isLoading.value = true;
    String data = jsonEncode({
      'fullname': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'location': address,
      'user_type': userType,
      'player_id': '868756755786576yy'
    });
    final response = await http.post(Uri.parse(REGISTER_API), body: data);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      signUpResponse.value = res['message'];
      isSuccess.value = res['success'];
      successRequest.value = true;
      if (res['success']) {
        box.write('email', email);
        box.write('password', password);
        successRequest.value = true;
      }
      isLoading.value = false;
    }
  }
}
