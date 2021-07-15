import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:v2/apis.dart';

class AuthonticationController extends GetxController {
  // int user_type;
  GetStorage box = GetStorage();
  RxBool success = false.obs;
  RxString userID = ''.obs;
  RxString roleID = ''.obs;
  RxString wardID = ''.obs;
  RxString message = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void signIn(
      String username, String password, String playerID, int userType) async {
    box.write('user_type', userType);
    print('Request sent');
    isLoading.toggle();
    // Map<String, dynamic> data = {
    //   'email': username,
    //   'password': password,
    //   'player_id': playerID,
    //   'user_type': userType
    // };

    var data = new Map<String, String>();
    data['email'] = username;
    data['password'] = password;
    data['player_id'] = playerID;
    data['user_type'] = userType.toString();
    // String data = jsonEncode({
    //   'email': username,
    //   'password': password,
    //   'player_id': playerID,
    //   'user_type': userType
    // });

    print(data);
    final response = await http.post(
      Uri.parse(SIGN_IN_API),
      body: data,
    );
    print(response.body);

    if (response.statusCode == 200) {
      var _data = jsonDecode(response.body);
      success.value = _data['success'];
      if (success.value) {
        userID.value = _data['user_id'];
        print('here is ddata: $_data');
        wardID.value = _data['ward_id'];
        roleID.value = _data['role_id'];
        message.value = _data['message'];
        box.write('user_id', userID.value);
        box.write('ward_id', userID.value);
        box.write('role_id', userID.value);
      } else {
        message.value = _data['message'];
      }
    } else {
      message.value = 'Server error';
    }
    isLoading.toggle();
  }

//   $userType = $_POST["user_type"];
// $fullname = $_POST["full_name"];
// $phone = $_POST["phone"];
// $email = $_POST["email"];
// $location = $_POST["location"];
// $school_id = $_POST["school_id"];
// $password = $_POST["password"];
// $player_id = $_POST["player_id"];

  void signUp(
      String userType,
      String fullName,
      String phone,
      String email,
      String location,
      String schoolID,
      String password,
      String playerID) async {
    var data = new Map<String, String>();
    data['email'] = email;
    data['password'] = password;
    data['player_id'] = playerID;
    data['user_type'] = userType.toString();
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['location'] = location;
    data['school_id'] = schoolID;
    data['password'] = password;
    data['player_id'] = playerID;
  }
}
