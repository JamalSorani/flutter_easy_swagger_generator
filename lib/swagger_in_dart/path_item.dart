// import 'operation.dart';

// class PathItem {
//   final Operation? get;
//   final Operation? post;
//   final Operation? put;
//   final Operation? patch;
//   final Operation? delete;

//   PathItem({this.get, this.post, this.put, this.patch, this.delete});

//   factory PathItem.fromJson(Map<String, dynamic> json) {
//     return PathItem(
//       get: json['get'] != null
//           ? Operation.fromJson(json['get'] as Map<String, dynamic>)
//           : null,
//       post: json['post'] != null
//           ? Operation.fromJson(json['post'] as Map<String, dynamic>)
//           : null,
//       put: json['put'] != null
//           ? Operation.fromJson(json['put'] as Map<String, dynamic>)
//           : null,
//       patch: json['patch'] != null
//           ? Operation.fromJson(json['patch'] as Map<String, dynamic>)
//           : null,
//       delete: json['delete'] != null
//           ? Operation.fromJson(json['delete'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'get': get?.toJson(),
//       'post': post?.toJson(),
//       'put': put?.toJson(),
//       'patch': patch?.toJson(),
//       'delete': delete?.toJson(),
//     };
//   }
// }
