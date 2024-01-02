import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  // Singleton instance
  static final PermissionManager _instance = PermissionManager._internal();

  factory PermissionManager() {
    return _instance;
  }

  PermissionManager._internal();

  // Request permission for accessing the camera
  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status == PermissionStatus.granted;
  }

  // Check if camera permission is granted
  Future<bool> hasCameraPermission() async {
    var status = await Permission.camera.status;
    return status == PermissionStatus.granted;
  }

  // Request permission for accessing the photo library
  Future<bool> requestPhotoPermission() async {
   var status = await Permission.photos.request();
    return status == PermissionStatus.granted;
  }

  // Check if photo library permission is granted
  Future<bool> hasPhotoPermission() async {
    var status = await Permission.photos.status;
    print("Photo permission status: $status");
    return status == PermissionStatus.granted;
  }

  // Request permission for accessing the device's location
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }

  // Check if location permission is granted
  Future<bool> hasLocationPermission() async {
    var status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

// Open the device's photo app
Future<File?> openPhotoApp() async {
  try {
    if (await hasPhotoPermission()) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      // Convert the XFile to File
      return pickedFile != null ? File(pickedFile.path) : null;
    } else {
      // Handle case where permission is not granted
      return null;
    }
  } catch (e) {
    print("Error opening photo app: $e");
    return null;
  }
}


  // Open the device's camera app
  Future<File?> openCameraApp() async {
    if (await hasCameraPermission()) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      return pickedFile != null ? File(pickedFile.path) : null;
    } else {
      // Handle case where permission is not granted
      return null;
    }
  }
}
