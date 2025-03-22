// // Define primitive types
// import 'media_type.dart';
// import 'method_type.dart';

// typedef TPrimitiveType = String;

// const String TPrimitiveTypeBoolean = "boolean";
// const String TPrimitiveTypeString = "string";

// // Define data types
// typedef TDataType = String;

// // Define primitive property interface
// class IPrimitiveProperty {
//   final TPrimitiveType type;

//   IPrimitiveProperty(this.type);
// }

// // Define array property interface
// class IArrayProperty {
//   final String type;
//   final IProperty? items;

//   IArrayProperty(this.type, {this.items});
// }

// // Define reference property interface
// class IRefProperty {
//   final String ref;
//   final String? type;

//   IRefProperty(this.ref) : type = null;
// }

// // Define the property properties
// typedef IPropertyProperties = Map<String, IProperty>;

// // Define object property interface
// class IObjectProperty {
//   final String type;
//   final IPropertyProperties? properties;
//   final IProperty? additionalProperties;

//   IObjectProperty(this.type, {this.properties, this.additionalProperties});
// }

// // Define the main property interface
// abstract class IProperty {
//   bool? nullable;
//   List<dynamic>? enumm;
//   List<IProperty>? oneOf;
//   List<IProperty>? anyOf;
//   List<IProperty>? allOf;
//   Map<String, dynamic>? AnyValue;
// }

// // Define specific property types
// class SystemTimeSpanProperty extends IProperty {
//   @override
//   bool? nullable;
//   @override
//   List<dynamic>? enumm;
//   @override
//   List<IProperty>? oneOf;
//   @override
//   List<IProperty>? anyOf;
//   @override
//   List<IProperty>? allOf;

//   SystemTimeSpanProperty() {
//     // This is equivalent to $ref: "#/components/schemas/System.TimeSpan"
//   }
// }

// // Define the parameter interface
// class IParameter {
//   final String name;
//   final String inn; // "query", "header", or "path"
//   final IProperty? schema;
//   final bool? required;

//   IParameter({
//     required this.name,
//     required this.inn,
//     this.schema,
//     this.required,
//   });
// }

// typedef IResponse = Map<int, ResponseDetails>;

// class ResponseDetails {
//   final String? description;
//   final Map<TMediaType, MediaContent>? content;

//   ResponseDetails({this.description, this.content});
// }

// // Define the request body type
// typedef IRequestBody = IResponse;

// // Define the OpenAPI JSON interface

// class Operation {
//   final String? summary;
//   final String? description;
//   final List<IParameter>? parameters;
//   final IRequestBody? requestBody;
//   final IResponse responses;

//   Operation({
//     this.summary,
//     this.description,
//     this.parameters,
//     this.requestBody,
//     required this.responses,
//   });
// }

// class Components {
//   final Map<String, IProperty> schemas;

//   Components(this.schemas);
// }

// // Define controller info
// typedef TControllerInfo = Map<String, List<TRouteInfo>>;

// // Define route info
// class TRouteInfo {
//   final bool hasResponse;
//   final bool hasBodyPayload;
//   final bool isArrayBodyPayload;
//   final bool hasQueryParams;
//   final bool hasPathParams;
//   final List<String> hasPageParamInBody;
//   final List<String> hasPageParamInQuery;
//   final TMethodType methodType;
//   final TMediaType mediaType;
//   final List<IParameter> parametersInPath;

//   TRouteInfo({
//     required this.hasResponse,
//     required this.hasBodyPayload,
//     required this.isArrayBodyPayload,
//     required this.hasQueryParams,
//     required this.hasPathParams,
//     required this.hasPageParamInBody,
//     required this.hasPageParamInQuery,
//     required this.methodType,
//     required this.mediaType,
//     required this.parametersInPath,
//   });
// }
