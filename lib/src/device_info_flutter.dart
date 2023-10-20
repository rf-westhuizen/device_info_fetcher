import 'package:flutter_device_identifier/flutter_device_identifier.dart';
import 'device_info_none.dart';

class DeviceInfoFlutter implements DeviceInfo {
  @override
  Future<String> get aSyncSerial async => await FlutterDeviceIdentifier.serialCode;
  /// TODO: Check platform Id package as it can get android-, web-, windows- based -ids
  @override
  Future<String> get id async =>  await FlutterDeviceIdentifier.androidID;

}

DeviceInfo getDeviceInfo() {

  DeviceInfoFlutter val = DeviceInfoFlutter();

  if(!DeviceInfo.serialCompleter.isCompleted && DeviceInfo.serial == ''){

    val.aSyncSerial.then((val)=> DeviceInfo.serialCompleter.complete(val));

  }
  return val;
}
