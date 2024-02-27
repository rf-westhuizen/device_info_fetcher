// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:io';

import 'package:device_info_fetcher/device_info_fetcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Different architecture', () {
    test('running on windows', () async {
      expect(Platform.isWindows, isTrue);
      final devInfo = getDeviceInfo();
      await Future.delayed(const Duration(seconds: 1));
      FutureOr<String> valueReceived = await devInfo.aSyncSerial;
      FutureOr<String> valueWanted = Platform.localHostname;
      expect(valueReceived, valueWanted);
    }, testOn: 'windows');

    test('running on android', () async {
      expect(Platform.isAndroid, isTrue);
      final devInfo = getDeviceInfo();
      await Future.delayed(const Duration(seconds: 1));
      String valueReceived = await devInfo.aSyncSerial;
      const paxHwId = '185';
      const pos9220Id = '922';
      const pos9310Id = '931';

      final hwId = valueReceived.substring(0, 3);
      expect(
          hwId.contains(paxHwId) ||
              hwId.contains(pos9220Id) ||
              hwId.contains(pos9310Id),
          isTrue);
    }, testOn: 'windows');
  });
}
