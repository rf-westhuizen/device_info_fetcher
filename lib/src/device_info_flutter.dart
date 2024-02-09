import 'dart:async';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:pax_api_plugin/pax_api_plugin.dart';
import 'device_info_none.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/services.dart';

class DeviceInfoFlutter implements DeviceInfo {
  final _posLinkApiV2Plugin = PaxApiPlugin();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String> getPosDeviceSerialNumber() async {
    try {
      final String deviceModel =
          await deviceInfo.androidInfo.then((value) => value.model);

      switch (deviceModel) {
        case 'IM30':
        case 'A50':
        case 'A35':
        case 'A920Pro':
        case 'A920':
        case 'PAX920':
          {
            final String serialNumber =
                await _posLinkApiV2Plugin.getSerialNumber() ??
                    'Could Not Obtain';
            final Map<String, dynamic> decoded = json.decode(serialNumber);
            final String sn = decoded['sn'] ?? "failing";
            return sn;
          }
        case 'NEW9310':
        case 'NEW9220':
          {
            return Future.value(
                deviceInfo.androidInfo.then((value) => value.serialNumber));
          }
        default:
          {
            return "Not implemented";
          }
      }
    } on PlatformException catch (e) {
      return "Failed to get serial number: ${e.message}";
    }
  }

  @override
  FutureOr<String> get aSyncSerial {
    if (isCompleted) {
      return serial;
    } else {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return getPosDeviceSerialNumber();
      }
      if (defaultTargetPlatform == TargetPlatform.windows) {
        return Future.value(
            deviceInfo.windowsInfo.then((value) => value.computerName));
      }
      return Future.value("Not implemented");
    }
  }

  /// TODO: Check platform Id package as it can get android-, web-, windows- based ids
  @override
  Future<String> get id async {
    switch (defaultTargetPlatform) {
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
    if (!DeviceInfo.serialCompleter.isCompleted) {
      throw Exception(
          'The UI serial property is not initialized'); // TODO: Implement Scotch ErrorOr return
    }
    return DeviceInfo.sSerial as String;
  }

  @override
  bool get isCompleted => DeviceInfo.serialCompleter.isCompleted;
}

DeviceInfo getDeviceInfo() {
  DeviceInfoFlutter val = DeviceInfoFlutter();

  if (!DeviceInfo.serialCompleter.isCompleted) {
    (val.aSyncSerial as Future).then((val) {
      if (!DeviceInfo.serialCompleter.isCompleted) {
        DeviceInfo.serialCompleter.complete(val);
      }
      DeviceInfo.sSerial = val;
    });
  }
  return val;
}
