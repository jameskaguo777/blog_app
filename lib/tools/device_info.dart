import 'package:device_info/device_info.dart';
import 'dart:io';

class DeviceInfo {
  Future<String> getAdnroidDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model;
  }

  Future<String> getIosDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.utsname.machine;
  }

  Future<String> getDeviceInfo() async {
    if (Platform.isAndroid) {
      return getAdnroidDeviceInfo();
    } else if (Platform.isIOS) {
      return getIosDeviceInfo();
    }
    return null;
  }
}