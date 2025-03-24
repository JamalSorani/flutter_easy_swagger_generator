import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'type/open_api_json.dart';

Future<IOpenApiJSON> loadSwaggerJson() async {
  final String jsonString = await rootBundle.loadString('lib/swagger.json');
  final jsonResponse = jsonDecode(jsonString);
  return IOpenApiJSON.fromJson(jsonResponse);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final IOpenApiJSON openApiJson = await loadSwaggerJson();
  log('Swagger JSON loaded successfully: ${openApiJson.info.title}');
}
