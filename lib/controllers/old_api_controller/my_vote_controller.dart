import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:v2/apis.dart';

class MyVoteController extends GetxController {
  var success = false.obs;
  var competitions = [].obs;
  var message = ''.obs;

  var isLoading = false.obs;
  GetStorage box = GetStorage();
  var userID;

  var competitionID = ''.obs;
  var competitionName = ''.obs;
  var competitionStatus = ''.obs;
  var competitionTheme = ''.obs;
  var images = [].obs;

  var comments = [].obs;

  @override
  void onInit() {
    super.onInit();
    userID = box.read('user_id');
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

//preparing output
// $response = array();
// $response["success"] = false;
// $response["competition_id"] = null;
// $response["competition_name"] = null;
// $response["competition_status"] = null;
// $response["competition_theme"] = null;
// $response["images"] = array();
// $response["message"] = "No competition available";
  void getImagesToVote() async {
    success.value = false;
    message.value = '';
    isLoading.toggle();
    var data = Map<String, String>();
    data['user_id'] = userID;

    final response = await http.post(Uri.parse(GET_PHOTOS_TO_VOTE));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      success.value = data['success'];
      if (success.value) {
        message.value = data['message'];
        competitionID.value = data['competition_id'];
        competitionName.value = data['competition_name'];
        competitionStatus.value = data['competition_status'];
        competitionTheme.value = data['competition_theme'];
        images.value = data['images'];
      } else {
        message.value = data['message'];
      }
    } else {}
    isLoading.toggle();
  }

  void getComments(String imageID) async {
    success.value = false;
    message.value = '';
    isLoading.toggle();
    var data = Map<String, String>();
    data['image_id'] = imageID;

    final response = await http.post(Uri.parse(GET_COMMENTS));

    if (response.statusCode == 200) {
      var dataJ = jsonDecode(response.body);
      success.value = dataJ['success'];
      if (success.value) {
        message.value = dataJ['message'];
        comments.value = dataJ['comments'];
      } else {
        message.value = dataJ['message'];
      }
    } else {}
    isLoading.toggle();
  }

  void postComment(String comment, String imageID) async {
    success.value = false;
    message.value = '';
    isLoading.toggle();
    var data = Map<String, String>();
    data['user_id'] = userID;
    data['image_id'] = imageID;
    data['comment'] = comment;

    final response = await http.post(Uri.parse(COMMENT_API));
    if (response.statusCode == 200) {
      var dataJ = jsonDecode(response.body);
      success.value = dataJ['success'];
      if (success.value) {
        message.value = dataJ['message'];
      } else {
        message.value = dataJ['message'];
      }
    } else {
      message.value = 'Sever error';
    }
    isLoading.toggle();
  }
}
