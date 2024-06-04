import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionService {
  Future<bool> isPermissionGranted(Permission permission);
  Future<bool> canRequest(Permission permission);
  Future<PermissionStatus> requestPermission(Permission permission);
}

class PermissionService implements IPermissionService {
  @override
  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  @override
  Future<bool> canRequest(Permission permission) async {
    return await permission.isDenied && !await permission.isPermanentlyDenied;
  }

  @override
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }
}
