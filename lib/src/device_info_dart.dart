import 'dart:io';
import 'device_info_none.dart';

class DeviceInfoDart implements DeviceInfo {
  @override
  /// TODO: get current pc serial
  Future<String> get serial => Future.value(Platform.localHostname); // LaptopName

  @override
  /// TODO get current pc identifier
  Future<String> get id => Future.value(Platform.operatingSystemVersion); // "Windows 10 Pro" 10.0 (Build 22621)
//Future<String> get id => Future.value(Platform.operatingSystem); // windows

}


DeviceInfo getDeviceInfo() {
  return DeviceInfoDart();
}

