import 'dart:io';
import 'package:flutter_easy_swagger_generator/helpers/formatter.dart';
import 'package:test/test.dart';

void main(List<String> list) {
  group('Swagger Generator Tests', () {
    late String testSwaggerPath;
    late String outputDir;

    setUp(() {
      // Create temporary test directory
      outputDir = Directory.systemTemp.createTempSync('swagger_test').path;
      testSwaggerPath = '$outputDir/test_swagger.json';

      // Create a minimal test swagger file
      final testSwagger = {
        'openapi': '3.0.0',
        'info': {
          'title': 'Test API',
          'version': '0.1.0',
        },
        'paths': {
          '/api/test': {
            'get': {
              'summary': 'Test endpoint',
              'responses': {
                '200': {
                  'description': 'Successful response',
                  'content': {
                    'application/json': {
                      'schema': {'\$ref': '#/components/schemas/TestResponse'}
                    }
                  }
                }
              }
            }
          }
        },
        'components': {
          'schemas': {
            'TestResponse': {
              'type': 'object',
              'properties': {
                'id': {'type': 'integer'},
                'name': {'type': 'string'}
              }
            }
          }
        }
      };

      File(testSwaggerPath).writeAsStringSync(testSwagger.toString());
    });

    tearDown(() {
      // Clean up test directory
      if (Directory(outputDir).existsSync()) {
        Directory(outputDir).deleteSync(recursive: true);
      }
    });

    test('should generate code from swagger file', () async {
      // Arrange
      final swaggerFile = File(testSwaggerPath);
      expect(swaggerFile.existsSync(), isTrue);

      // Act
      main([testSwaggerPath]);

      // Assert
      // Check if generated files exist
      expect(Directory('lib/app').existsSync(), isTrue);
      expect(Directory('lib/app/domain').existsSync(), isTrue);
      expect(Directory('lib/app/infrastructure').existsSync(), isTrue);
      expect(Directory('lib/app/network').existsSync(), isTrue);
    });

    test('should handle invalid swagger file path', () {
      // Arrange
      const invalidPath = 'invalid/path/swagger.json';

      // Act & Assert
      expect(() => main([invalidPath]), throwsA(isA<FileSystemException>));
    });

    test('should handle malformed swagger JSON', () {
      // Arrange
      File(testSwaggerPath).writeAsStringSync('{invalid json}');

      // Act & Assert
      expect(() => main([testSwaggerPath]), throwsA(isA<FormatException>));
    });
  });

  group('Formatter Tests', () {
    late String testDir;

    setUp(() {
      testDir = Directory.systemTemp.createTempSync('formatter_test').path;

      // Create some test Dart files
      for (var i = 0; i < 3; i++) {
        File('$testDir/test_$i.dart').writeAsStringSync('''
void main() {
  print('Test $i');
}
''');
      }
    });

    tearDown(() {
      if (Directory(testDir).existsSync()) {
        Directory(testDir).deleteSync(recursive: true);
      }
    });

    test('should format Dart files', () async {
      // Act
      await formatDirectory(testDir);

      // Assert
      final files = Directory(testDir)
          .listSync()
          .where((entity) => entity is File && entity.path.endsWith('.dart'))
          .toList();

      expect(files.length, equals(3));

      // Check if files are properly formatted
      for (final file in files) {
        final content = File(file.path).readAsStringSync();
        expect(content.contains('\n\n'), isTrue); // Basic formatting check
      }
    });
  });
}
