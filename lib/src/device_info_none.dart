import 'dart:async';

// This class defines the interface for retrieving device information.
abstract class DeviceInfo {
  // 2 asynchronous abstract methods, both of which will return futures of strings
  FutureOr<String> get aSyncSerial;
  Future<String> get id;

  // This is a completer object, with a return type of string
  static Completer<String> serialCompleter = Completer<String>();
  // The 'serial' will listen for any changes from the 'serialCompleter'
  static FutureOr<String> sSerial = serialCompleter.future;
  // When serialCompleter.complete(val) then the sSerial holds the serial number

  // 2 abstract properties for this 'interface' class
  String get serial;
  bool get isCompleted;
}

// factory function: Its purpose is to create and return an instance
// of a specific implementation of 'DeviceInfo'
// based on the platform where the code is running from
DeviceInfo getDeviceInfo() {
// Don't implement analyzer uses this stub, to assist with coding
// device_info_flutter and device_info_dart used in compilations
  throw UnimplementedError();
}
