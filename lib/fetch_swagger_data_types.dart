enum TMethodType {
  get,
  post,
  put,
  delete,
  patch,
}

enum TMediaType {
  multipartFormData,
  applicationJson,
  textPlain,
  textJson,
  applicationJsonPlus,
}

enum TNumberType {
  integer,
  number,
}

//export type TPrimitiveType = TNumberType | "boolean" | "string"; // (string includes dates and files);
enum TPrimitiveType {
  integer,
  number,
  boolean,
  string,
}

//export type TDataType = TPrimitiveType | "array" | "object";
enum TDataType {
  integer,
  number,
  boolean,
  string,
  array,
  object,
}

class IPrimitiveProperty {
  final TPrimitiveType type;

  IPrimitiveProperty({required this.type});
}

class IArrayProperty {
  final TDataType type = TDataType.array;
  final IProperty? items;

  IArrayProperty({this.items});
}

class IRefProperty {
  final String
      ref; //`#/components/schemas/\${string}` | `#/components/schemas/\${string}.Enums.\${string}`;
  //type?: undefined;

  IRefProperty({required this.ref});
}

class IPropertyProperties {
  //[propertyName: string]: IProperty;
  final Map<String, IProperty> properties;

  IPropertyProperties({required this.properties});
}

class IObjectProperty {
  final TDataType type = TDataType.object;
  final IPropertyProperties? properties;
  final dynamic additionalProperties; //IProperty | true;

  IObjectProperty({this.properties, this.additionalProperties});
}

class IProperty {
  final TPrimitiveType? type;
  final String? ref;
  final bool? nullable;
  final List<dynamic>? enumeration;
  final List<IProperty>? oneOf;
  final List<IProperty>? anyOf;
  final List<IProperty>? allOf;
  final dynamic anyValue;

  IProperty({
    this.type,
    this.ref,
    this.nullable,
    this.enumeration,
    this.oneOf,
    this.anyOf,
    this.allOf,
    this.anyValue,
  });
}

class IParameter {
  final String name;
  final String
      inValue; //"query" | "header" | "path"; // in path example: /users/{userId}
  final IProperty? schema;
  final bool? required;

  IParameter({
    required this.name,
    required this.inValue,
    this.schema,
    this.required,
  });
}

class IResponse {
  final Map<String, dynamic> responses;
  IResponse({required this.responses});
}

class IRequestBody {
  final String? description;
  final Map<TMediaType, dynamic>? content;

  IRequestBody({this.description, this.content});
}

class IOpenApiJSON {
  final String openapi; // version
  final IInfo info;
  final List<IServer>? servers;
  final Map<String, dynamic> paths;
  final IComponents components;

  IOpenApiJSON({
    required this.openapi,
    required this.info,
    this.servers,
    required this.paths,
    required this.components,
  });
}

class IInfo {
  final String title;
  final String description;
  final String version;
  final IContact? contact;

  IInfo({
    required this.title,
    required this.description,
    required this.version,
    this.contact,
  });
}

class IContact {
  final String? name;

  IContact({this.name});
}

class IServer {
  final String url;
  final String description;

  IServer({required this.url, required this.description});
}

class IComponents {
  final Map<String, IProperty> schemas;

  IComponents({required this.schemas});
}

class TControllerInfo {
  final Map<String, List<TRouteInfo>> controllerInfo;

  TControllerInfo({required this.controllerInfo});
}

class TRouteInfo {
  final Map<String, dynamic> routeInfo;

  TRouteInfo({required this.routeInfo});
}
