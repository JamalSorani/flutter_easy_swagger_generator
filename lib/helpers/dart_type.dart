String getDartType(String? swaggerType) {
  switch (swaggerType) {
    case 'string':
      return 'String';
    case 'integer':
      return 'int';
    case 'number':
      return 'double';
    case 'boolean':
      return 'bool';
    default:
      return 'dynamic';
  }
}
