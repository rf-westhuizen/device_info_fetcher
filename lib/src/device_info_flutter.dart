import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'device_info_none.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';

class DeviceInfoFlutter implements DeviceInfo {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  FutureOr<String> get aSyncSerial {

    if(isCompleted){
      return serial;
    } else{
      if(defaultTargetPlatform == TargetPlatform.android) {
        return Future.value(deviceInfo.androidInfo.then((value) => value.serialNumber));
      }
      if(defaultTargetPlatform == TargetPlatform.windows) {
        return Future.value(deviceInfo.windowsInfo.then((value) => value.computerName));
      }
      return Future.value("Not implemented");
    }

  }

  /// TODO: Check platform Id package as it can get android-, web-, windows- based ids
  @override
  Future<String> get id async {
    switch(defaultTargetPlatform){
      case TargetPlatform.android:
        return (await deviceInfo.androidInfo).id;
      case TargetPlatform.windows:
        return (await deviceInfo.windowsInfo).deviceId;
      default:
        return "Not implemented";
    }
  }



  @override
  String get serial {
    if(!DeviceInfo.serialCompleter.isCompleted){
      throw Exception('The UI serial property is not initialized'); // TODO: Implement Scotch ErrorOr return
    }
    return DeviceInfo.sSerial as String;
  }

  @override
  bool get isCompleted => DeviceInfo.serialCompleter.isCompleted;

}

DeviceInfo getDeviceInfo() {

  DeviceInfoFlutter val = DeviceInfoFlutter();

  if(!DeviceInfo.serialCompleter.isCompleted || DeviceInfo.sSerial == ""){

    (val.aSyncSerial as Future).then((val) {
      if (!DeviceInfo.serialCompleter.isCompleted) {
        DeviceInfo.serialCompleter.complete(val);
        DeviceInfo.sSerial = val;
      }
    });

  }
  return val;
}
