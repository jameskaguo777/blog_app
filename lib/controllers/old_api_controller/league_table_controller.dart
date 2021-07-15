import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../apis.dart';

class LeagueTableController extends GetxController {
  var success = false.obs;
  var competitions = [].obs;
  var message = ''.obs;
  var isLoading = false.obs;
  var schools = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getCompetition() async {
    success.value = false;
    message.value = '';
    isLoading.toggle();
    final response = await http.get(Uri.parse(GET_COMPETITIONS));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      success.value = data['success'];
      if (success.value) {
        message.value = data['message'];
        competitions.value = data['competitions'];
      } else {
        message.value = data['message'];
      }
      print(data);
    }
    isLoading.toggle();
  }

  void getLeagueTables(String competitionID) async {
    var data = Map<String, String>();
    data['competition_id'] = competitionID;

    final response = await http.post(Uri.parse(LEAGUE_TABLE_API));

    if (response.statusCode == 200) {
      var dataJ = jsonDecode(response.body);
      success.value = dataJ['success'];

      if (success.value) {
        message.value = dataJ['message'];
        schools.value = dataJ['schools'];
      } else {
        message.value = dataJ['message'];
      }
    }
  }
}
