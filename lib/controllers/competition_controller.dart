import 'package:get/get.dart';
import 'package:v2/controllers/check_token_controller.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CompetitionController extends GetxController {
  CheckTokenController _checkTokenController = Get.find();

  var theme = ''.obs;
  var challenge = ''.obs;
  var reward = ''.obs;
  var criteria = ''.obs;
  var target = ''.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var geoLocked = false.obs;
  var coordinates = ''.obs;
  var radius = 0.obs;
  var imageUrl = ''.obs;
  var status = false.obs;
  var remainingDaysPercentage = 0.0.obs;
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
      theme.value = body['data']['theme'];
      challenge.value = body['data']['challenge'];
      reward.value = body['data']['reward'];
      criteria.value = body['data']['criteria'];
      target.value = body['data']['target'];
      startDate.value = body['data']['start_date'];
      endDate.value = body['data']['end_date'];
      geoLocked.value = body['data']['geo_locked'];
      coordinates.value = body['data']['coordinates'];
      radius.value = body['data']['radius'];
      imageUrl.value = body['data']['image_url'];
      status.value = body['data']['status'];
      remainingDaysPercentage.value = body['data']['remaining_days_percentage'];
    }
  }
}
