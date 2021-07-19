import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:v2/apis.dart';

class WashAmbassador extends GetxController {
  var message = ''.obs;
  var success = false.obs;
  var isLoading = false.obs;
  var ambassador = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getAmbassador() async {
    isLoading.toggle();
    final response = await http.get(Uri.parse(GET_AMBASSADORS));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      success.value = data['success'];
      if (success.value) {
        message.value = data['message'];
        ambassador.value = data['voters'];
      } else {
        message.value = data['message'];
      }
    } else {
      message.value = 'sever error';
    }
    isLoading.toggle();
  }
}
