import 'package:flutter/cupertino.dart';
import 'package:fresh_feed/utils/app_alerts.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  PermissionHandlerService._();
  static final _instance = PermissionHandlerService._();
  factory PermissionHandlerService() {
    return _instance;
  }
  static Future<void> requestPermissions() async {
    await _requestPermission(Permission.camera, "Camera");
    await _requestPermission(Permission.microphone, "Microphone");
    await _requestPermission(Permission.storage, "Storage");
    await _requestPermission(Permission.location, "Location");
    await _requestPermission(Permission.sms, "SMS");
  }

  static Future<PermissionStatus> _requestPermission(
      Permission permission, String permissionName) async {
    if (await permission.isGranted) {
      print("$permissionName permission is already granted.");
      return PermissionStatus.granted; // No need to request it again
    }
    PermissionStatus status = await permission.request();
    return status;
  }

  static Future<bool> checkPermissionStatus(Permission permission,
      String permissionName, BuildContext context) async {
    PermissionStatus status =
        await _requestPermission(permission, permissionName);

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      AppAlerts.displaySnackBar(
          "$permissionName permission is required!", context);
      return false;
    } else if (status.isPermanentlyDenied) {
      Future<bool> callback() async {
        Navigator.pop(context);
        return openAppSettings();
      }

      return await AppAlerts.displayPermissionDialog(
        callback,
        "Go to Settings",
        "$permissionName permission is permanently denied. Open app settings to enable it.",
        context,
      );
    } else if (status.isRestricted) {
      AppAlerts.displaySnackBar(
          "$permissionName permission is restricted. Please check device restrictions.",
          context);
      return false;
    } else {
      AppAlerts.displaySnackBar(
          "Unable to determine $permissionName status.", context);
      return false;
    }
  }
}
