import 'property.dart';

class Components {
  final Map<String, IProperty> schemas;

  Components({required this.schemas});

  @override
  String toString() {
    return 'Components{schemas: $schemas}';
  }
}
