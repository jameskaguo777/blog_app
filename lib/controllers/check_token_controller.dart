import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CheckTokenController extends GetxController {
  GetStorage box = GetStorage();
  var token = 'null'.obs;

  @override
  void onInit() {
    super.onInit();
    token.value = box.read('access_token');
  }

  void getTokenF() {
    token.value = box.read('access_token');
  }
}
