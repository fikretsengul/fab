/// Enum representing different types of permissions.
enum PermissionType {
  /// Permission for accessing the device's calendar.
  /// Deprecated: Use [calendarWriteOnly] and [calendarFullAccess].
  calendar,

  /// Permission for accessing the device's camera.
  camera,

  /// Permission for accessing the device's contacts.
  contacts,

  /// Permission for accessing the device's location.
  location,

  /// Permission for accessing the device's location always.
  locationAlways,

  /// Permission for accessing the device's location when in use.
  locationWhenInUse,

  /// Permission for accessing the device's media library.
  mediaLibrary,

  /// Permission for accessing the device's microphone.
  microphone,

  /// Permission for accessing the device's phone state.
  phone,

  /// Permission for accessing the device's photos.
  photos,

  /// Permission for adding photos only.
  photosAddOnly,

  /// Permission for accessing the device's reminders.
  reminders,

  /// Permission for accessing the device's sensors.
  sensors,

  /// Permission for sending and reading SMS messages.
  sms,

  /// Permission for accessing speech recognition.
  speech,

  /// Permission for accessing external storage.
  storage,

  /// Permission for ignoring battery optimizations.
  ignoreBatteryOptimizations,

  /// Permission for pushing notifications.
  notification,

  /// Permission for accessing media location.
  accessMediaLocation,

  /// Permission for accessing activity recognition.
  activityRecognition,

  /// Unknown permission, used as a placeholder.
  unknown,

  /// Permission for accessing Bluetooth adapter state.
  bluetooth,

  /// Permission for managing external storage.
  manageExternalStorage,

  /// Permission for creating system alert window.
  systemAlertWindow,

  /// Permission for requesting package installation.
  requestInstallPackages,

  /// Permission for app tracking transparency.
  appTrackingTransparency,

  /// Permission for sending critical alerts.
  criticalAlerts,

  /// Permission for accessing notification policy.
  accessNotificationPolicy,

  /// Permission for scanning Bluetooth devices.
  bluetoothScan,

  /// Permission for advertising Bluetooth devices.
  bluetoothAdvertise,

  /// Permission for connecting Bluetooth devices.
  bluetoothConnect,

  /// Permission for connecting to nearby Wi-Fi devices.
  nearbyWifiDevices,

  /// Permission for accessing video files from external storage.
  videos,

  /// Permission for accessing audio files from external storage.
  audio,

  /// Permission for scheduling exact alarms.
  scheduleExactAlarm,

  /// Permission for accessing sensors always.
  sensorsAlways,

  /// Permission for writing to the calendar.
  calendarWriteOnly,

  /// Permission for full access to the calendar.
  calendarFullAccess,
}
