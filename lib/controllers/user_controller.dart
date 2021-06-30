import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:v2/constants/new_api.dart';
import 'package:v2/controllers/check_token_controller.dart';

class UserController extends GetxController {
  var name = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  String token;
  CheckTokenController _checkTokenController = Get.find();
  GetStorage box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    token = _checkTokenController.token.value;
    
  }

  void userDetails() async {
    print('token is $token');
    final response = await http.get(Uri.parse(USER), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Content-Type': 'application/json'
    });
    print(response.body);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      name.value = body['data']['name'];
    }
    print(response.body);
  }
}
