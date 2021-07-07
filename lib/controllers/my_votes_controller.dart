import 'package:get/get.dart';
import 'package:v2/constants/new_api.dart';
import 'package:v2/controllers/check_token_controller.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyVotesController extends GetxController {
  var isSuccessful = false.obs;
  var mediaUrls = [].obs;
  var comments = [].obs;
  var isLoading = false.obs;
  var theme = ''.obs;
  var data = [].obs;
  CheckTokenController _checkTokenController = Get.find();
  String token;

  @override
  void onInit() {
    super.onInit();
    token = _checkTokenController.token.value;
    getParticipant();
  }

  void getParticipant() async {
    isLoading.value = true;
    final response =
        await http.get(Uri.parse(GET_COMPETITION_PARTICIPANTS_A), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      data.value = body['data'];
    }
    isLoading.value = false;
  }

  void vote(int competitionParticipantID, int points) {
    String data = jsonEncode({
      'competition_participant_id': competitionParticipantID,
      'point': points
    });
    final response = http.post(Uri.parse(VOTE),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: data);
  }
}
