import 'dart:async';
import 'dart:io';
import 'device_info_none.dart';

class DeviceInfoDart implements DeviceInfo {

  @override
  FutureOr<String> get aSyncSerial {

  if(isCompleted){
    return serial;
  } else{
    return Future.value(Platform.localHostname);
  }

  }

  @override
  //Future<String> get id => Future.value(Platform.operatingSystemVersion); // "Windows 10 Pro" 10.0 (Build 22621)
  Future<String> get id => Future.value(Platform.operatingSystem);


  @override
  // TODO: if not completed throw an error
  String get serial {

  if (!DeviceInfo.serialCompleter.isCompleted){
    throw Exception('The IO serial property is not initialized'); // TODO: Implement Scotch ErrorOr return
  }
    return DeviceInfo.sSerial as String;
  }

  @override
  bool get isCompleted => DeviceInfo.serialCompleter.isCompleted;

}


DeviceInfo getDeviceInfo() {

  DeviceInfoDart val = DeviceInfoDart();

  if(!DeviceInfo.serialCompleter.isCompleted){

    (val.aSyncSerial as Future).then((val) {
      if (!DeviceInfo.serialCompleter.isCompleted) {
        DeviceInfo.serialCompleter.complete(val);
      }
      DeviceInfo.sSerial = val;
    });

  }
  return val;
}

