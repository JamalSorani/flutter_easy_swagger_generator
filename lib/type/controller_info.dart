import 'route_info.dart';

class TControllerInfo {
  final Map<String, List<RouteInfo>> controllers;

  TControllerInfo({required this.controllers});

  @override
  String toString() {
    return 'TControllerInfo{controllers: $controllers}';
  }
}
