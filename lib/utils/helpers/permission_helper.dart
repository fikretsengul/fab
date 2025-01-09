import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPhotosPermission() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await Permission.photos.request();

    if (await Permission.photos.isLimited || await Permission.photos.isGranted) {
      return true;
    } else if (await Permission.photos.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }

  return false;
}
