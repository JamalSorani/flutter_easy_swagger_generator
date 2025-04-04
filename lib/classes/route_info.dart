import 'media_type.dart';
import 'method_type.dart';
import 'parameter.dart';

class RouteInfo {
  final Map<String, RouteDetails> routes;

  RouteInfo({required this.routes});
}

class RouteDetails {
  final bool hasResponse;
  final bool hasBodyPayload;
  final bool isArrayBodyPayload;
  final bool hasQueryParams;
  final bool hasPathParams;
  final List<String> hasPageParamInBody;
  final List<String> hasPageParamInQuery;
  final TMethodType methodType;
  final MediaTypeContent mediaType;
  final List<IParameter> parametersInPath;

  RouteDetails({
    required this.hasResponse,
    required this.hasBodyPayload,
    required this.isArrayBodyPayload,
    required this.hasQueryParams,
    required this.hasPathParams,
    required this.hasPageParamInBody,
    required this.hasPageParamInQuery,
    required this.methodType,
    required this.mediaType,
    required this.parametersInPath,
  });
}
