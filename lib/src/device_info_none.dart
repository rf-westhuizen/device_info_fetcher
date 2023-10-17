abstract class DeviceInfo {
  // 2 abstract methods, both of which will return futures of strings
  Future<String> get serial;
  Future<String> get id;
}

// factory function: Its purpose is to create and return an instance
// of a specific implementation of 'DeviceInfo'
// based on the platform where the code is running from
DeviceInfo getDeviceInfo() {
// Don't implement analyzer uses this stub, to assist with coding
// device_info_flutter and device_info_dart used in compilations
  throw UnimplementedError();
}

