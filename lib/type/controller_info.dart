import 'route_info.dart';

class TControllerInfo {
  final Map<String, List<TRouteInfo>> controllers;

  TControllerInfo({required this.controllers});

  @override
  String toString() {
    return 'TControllerInfo{controllers: $controllers}';
  }
}
