import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return permission.request();
  }

  bool isPermissionGranted(PermissionStatus status) {
    return status.isGranted;
  }
}
