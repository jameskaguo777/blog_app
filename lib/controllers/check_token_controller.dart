import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CheckTokenController extends GetxController {
  final box = GetStorage();
  var token = 'null'.obs;

  @override
  void onInit() {
    super.onInit();
    box.listenKey('access_token', (value) => token.value = value);
    token.value = box.read('access_token');
    print('sawa ${box.read('test')}');
  }

  // void getTokenF() {
  //   token.value = box.read('access_token');
  // }
}
