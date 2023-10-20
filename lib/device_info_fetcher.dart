library;

// conditional export statement method
export 'src/device_info_none.dart'  // Logic to tell project yaml which to import
if (dart.library.ui) 'src/device_info_flutter.dart'// UI only exist in Flutter declare our flutter implementation
if (dart.library.io) 'src/device_info_dart.dart'; // All except web contain IO, used as else. Declare dart implementation

/// This allows pure dart applications to run without flutter
/// As in pepkor we use 32-bit dart which flutter does not support


