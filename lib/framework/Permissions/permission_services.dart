import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<bool> requestPermission(Permission permission);
  Future<bool> requestPermissions(List<Permission> permissions);
  Future<bool> hasPermission(Permission permission);
  Future<bool> hasPermissions(List<Permission> permissions);
}

class PermissionServiceImpl implements PermissionService {
  @override
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  @override
  Future<bool> requestPermissions(List<Permission> permissions) async {
    final statuses = await permissions.request();
    return statuses.values.every((status) => status.isGranted);
  }

  @override
  Future<bool> hasPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  @override
  Future<bool> hasPermissions(List<Permission> permissions) {
    // TODO: implement hasPermissions
    throw UnimplementedError();
  }
}
