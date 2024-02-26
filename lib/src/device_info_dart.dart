import 'dart:async';
import 'dart:io';
import 'package:device_info_fetcher/src/enum/device_type.dart';

import 'device_info_none.dart';

class DeviceInfoDart implements DeviceInfo {
  @override
  FutureOr<String> get aSyncSerial {
    if (isSerialCompleted) {
      return serial;
    } else {
      return Future.value(Platform.localHostname);
    }
  }

  @override
  //Future<String> get id => Future.value(Platform.operatingSystemVersion); // "Windows 10 Pro" 10.0 (Build 22621)
  Future<String> get id => Future.value(Platform.operatingSystem);

  @override
  // TODO: if not completed throw an error
  String get serial {
    if (!DeviceInfo.serialCompleter.isCompleted) {
      throw Exception(
          'The IO serial property is not initialized'); // TODO: Implement Scotch ErrorOr return
    }
    return DeviceInfo.sSerial as String;
  }

  @override
  bool get isSerialCompleted => DeviceInfo.serialCompleter.isCompleted;
  @override
  bool get isTypeCompleted => DeviceInfo.typeCompleter.isCompleted;

  @override
  // TODO: implement aType
  FutureOr<DeviceType> get aType {
    if (isTypeCompleted) {
      return deviceType;
    } else {
      return Future.value(DeviceType.windows);
    }
  }

  @override
  // TODO: implement deviceType
  DeviceType get deviceType {
    if (!DeviceInfo.typeCompleter.isCompleted) {
      throw Exception(
          'The IO type property is not initialized'); // TODO: Implement Scotch ErrorOr return
    }
    return DeviceInfo.sType as DeviceType;
  }

}

DeviceInfo getDeviceInfo() {
  DeviceInfoDart val = DeviceInfoDart();

  if (!DeviceInfo.serialCompleter.isCompleted) {
    (val.aSyncSerial as Future).then((val) {
      if (!DeviceInfo.serialCompleter.isCompleted) {
        DeviceInfo.serialCompleter.complete(val);
      }
      DeviceInfo.sSerial = val;
    });
  }

  if (!DeviceInfo.typeCompleter.isCompleted) {
    (val.aType as Future).then((val) {
      if (!DeviceInfo.typeCompleter.isCompleted) {
        DeviceInfo.typeCompleter.complete(val);
      }
      DeviceInfo.sType = val;
    });
  }
  return val;
}
