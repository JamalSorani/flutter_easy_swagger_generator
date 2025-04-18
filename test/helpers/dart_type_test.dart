// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/property.dart';
import 'package:flutter_easy_swagger_generator/helpers/dart_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getDartType', () {
    late Components components;

    setUp(() {
      components = Components(schemas: {
        'TestModel': TProperty(type: 'object'),
        'SimpleEnum': TProperty(type: 'string'),
      });
    });

    test('handles null schema', () {
      final result = getDartType(null, components);
      expect(result.className, 'dynamic');
      expect(result.schema, null);
    });

    test('handles primitive array', () {
      final schema = ArrayProperty(
        type: 'array',
        items: PrimitiveProperty(type: 'string'),
      );
      final result = getDartType(schema, components);
      expect(result.className, 'List<String>');
      expect(result.schema, schema);
      expect(result.isRef, false);
    });

    test('handles array of references', () {
      final schema = ArrayProperty(
        type: 'array',
        items: RefProperty(ref: '#/components/schemas/TestModel'),
      );
      final result = getDartType(schema, components);
      expect(result.className, 'List<TestModel>');
      expect(result.schema, schema);
      expect(result.isRef, true);
    });

    test('handles nested arrays', () {
      final schema = ArrayProperty(
        type: 'array',
        items: ArrayProperty(
          type: 'array',
          items: PrimitiveProperty(type: 'integer'),
        ),
      );
      final result = getDartType(schema, components);
      expect(result.className, 'List<List<int>>');
      expect(result.schema, schema);
      expect(result.isRef, false);
    });

    test('handles primitive types', () {
      final schema = PrimitiveProperty(type: 'string');
      final result = getDartType(schema, components);
      expect(result.className, 'String');
      expect(result.schema, schema);
      expect(result.isRef, false);
    });

    test('handles reference types', () {
      final schema = RefProperty(ref: '#/components/schemas/TestModel');
      final result = getDartType(schema, components);
      expect(result.className, 'TestModel');
      expect(result.schema, schema);
      expect(result.isRef, true);
    });
  });
}
