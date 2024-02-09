import 'dart:async';
import 'dart:io';
import 'package:test/test.dart';
import 'package:device_info_fetcher/src/device_info_dart.dart';

void main() {
  group('Serial Properties:', () {
    late dynamic deviceInfoDart;
    setUp(() {
      deviceInfoDart = DeviceInfoDart();
    });

    test('version should throw an exception if completer is not finished',
        () async {
      expect(() => deviceInfoDart.serial, throwsException);
    });
  });

  group('device info DART fetcher test:', () {
    test('isCompleted finished:', () async {
      getDeviceInfo();
      await Future.delayed(const Duration(seconds: 1));
      bool valueReceived = getDeviceInfo().isCompleted;
      expect(valueReceived, true);
    });

    // Test the `serial` return value
    test('serial should return the serial value if it is initialized',
        () async {
      getDeviceInfo();
      await Future.delayed(const Duration(seconds: 1));

      FutureOr<String> valueReceived = await getDeviceInfo().aSyncSerial;
      FutureOr<String> valueWanted = Platform.localHostname;

      expect(valueReceived, valueWanted);
    });
  });

  group('Different architecture', () {
    test('flutter windows', () async {
      if (Platform.isWindows) {
        getDeviceInfo();
        await Future.delayed(const Duration(seconds: 1));
        FutureOr<String> valueReceived = await getDeviceInfo().aSyncSerial;
        FutureOr<String> valueWanted = Platform.localHostname;
        expect(valueReceived, valueWanted);
      }
    }, testOn: 'windows');
  });

  group('Different architecture', () {
    test(
      'pure dart',
      () async {
        getDeviceInfo();
        await Future.delayed(const Duration(seconds: 1));
        FutureOr<String> valueReceived = await getDeviceInfo().aSyncSerial;
        FutureOr<String> valueWanted = Platform.localHostname;
        expect(valueReceived, valueWanted);
      },
      testOn: 'vm',
    );
  });
}

// // Test the `get serial` logic
// test('serial should return the sSerial after completer completed or an Error', () async {
//
//   // Create a device info object with the completer completed.
//   final deviceInfo = getDeviceInfo();
//
//   expect(() => deviceInfo.serial, throwsException);
//
//
// });
