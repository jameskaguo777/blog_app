import 'package:get/get.dart';
import 'package:v2/controllers/check_token_controller.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LeagueTableController extends GetxController {
  CheckTokenController _checkTokenController = Get.find();

  var idA = 0.obs;
  var themeA = ''.obs;
  var challengeA = ''.obs;
  var rewardA = ''.obs;
  var criteriaA = ''.obs;
  var targetA = ''.obs;
  var startDateA = ''.obs;
  var endDateA = ''.obs;
  var geoLockedA = false.obs;
  var coordinatesA = ''.obs;
  var radiusA = 0.obs;
  var imageUrlA = ''.obs;
  var statusA = false.obs;
  var remainingDaysPercentageA = 0.0.obs;

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
      idA.value = body['data']['id'];
      themeA.value = body['data']['theme'];
      challengeA.value = body['data']['challenge'];
      rewardA.value = body['data']['reward'];
      criteriaA.value = body['data']['criteria'];
      targetA.value = body['data']['target'];
      startDateA.value = body['data']['start_date'];
      endDateA.value = body['data']['end_date'];
      geoLockedA.value = body['data']['geo_locked'];
      coordinatesA.value = body['data']['coordinates'];
      radiusA.value = body['data']['radius'];
      imageUrlA.value = body['data']['image_url'];
      statusA.value = body['data']['status'];
      remainingDaysPercentageA.value =
          body['data']['time_spended']['time_spended_in_percentage'];
    }
  }

  void getAllCompetition() async {
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

  void getParticipantsCompetition(int competitionId) async {
    // TODO @jameskaguo
    final response = await http.get(Uri.parse('uri'));
  }
}
