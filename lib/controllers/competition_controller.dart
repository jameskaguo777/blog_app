import 'package:get/get.dart';
import 'package:v2/controllers/check_token_controller.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CompetitionController extends GetxController {
  CheckTokenController _checkTokenController = Get.find();

  var name = ''.obs;
  String token;
  @override
  void onInit() {
    super.onInit();
    token = _checkTokenController.token.value;
  }

  void getActiveCompetition() async {
    final response = await http.get(Uri.parse('uri'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      name.value = body['data']['title'];
    }
  }
}
