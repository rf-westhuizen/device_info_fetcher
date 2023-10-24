import 'dart:async';

import 'package:flutter_device_identifier/flutter_device_identifier.dart';
import 'device_info_none.dart';

class DeviceInfoFlutter implements DeviceInfo {


  @override
  /// TODO: get current pc serial
  FutureOr<String> get aSyncSerial {

    if(isCompleted){
      return serial;
    } else{
      return Future.value(FlutterDeviceIdentifier.serialCode);
    }

  }

  /// TODO: Check platform Id package as it can get android-, web-, windows- based -ids
  @override
  Future<String> get id async =>  await FlutterDeviceIdentifier.androidID;


  @override
  // TODO: implement serial
  String get serial {
    if(!DeviceInfo.serialCompleter.isCompleted){
      throw Exception('The UI serial property is not initialized'); // TODO: Implement Scotch ErrorOr return
    }
    return DeviceInfo.sSerial as String;
  }

  @override
  // TODO: implement isInitialized
  bool get isCompleted => DeviceInfo.serialCompleter.isCompleted;

}

DeviceInfo getDeviceInfo() {

  DeviceInfoFlutter val = DeviceInfoFlutter();

  if(!DeviceInfo.serialCompleter.isCompleted || DeviceInfo.sSerial == ""){

    (val.aSyncSerial as Future).then((val) {
       DeviceInfo.serialCompleter.complete(val);
       DeviceInfo.sSerial = val;
    });

  }
  return val;
}
