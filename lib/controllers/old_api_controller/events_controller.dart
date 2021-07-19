import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:v2/apis.dart';

class EventController extends GetxController {
  GetStorage box = GetStorage();
  var message = ''.obs;
  var success = false.obs;
  var isLoading = false.obs;
  var competitions = [].obs;

  String userID;

  var posts = [].obs;

  @override
  void onInit() {
    super.onInit();
    userID = box.read('user_id');
  }

  void getPost() async {
    isLoading.toggle();
    success.value = false;
    message.value = '';
    final response = await http.get(Uri.parse(GET_POSTS));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      success.value = data['success'];
      if (success.value) {
        message.value = data['message'];
        posts.value = data['posts'];
      } else {
        message.value = data['message'];
      }
    } else {
      message.value = 'server error';
    }
    isLoading.toggle();
  }

  void postComment(String postID, String comment) async {
    isLoading.toggle();
    success.value = false;
    message.value = '';

    var data = Map<String, String>();
    data['user_id'] = userID;
    data['post_id'] = postID;
    data['comment'] = comment;

    final response = await http.post(Uri.parse(POST_COMMENT_API), body: data);

    if (response.statusCode == 200) {
      var dataJ = jsonDecode(response.body);
      success.value = dataJ['success'];
      if (success.value) {
        message.value = dataJ['message'];
      } else {
        message.value = dataJ['message'];
      }
    } else {
      message.value = 'sever error';
    }
    isLoading.toggle();
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

  void getActiveCompetition() {}
}
