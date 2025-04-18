class ChangeBlockStatusEmployeeCommandModel {
  final String id;

  ChangeBlockStatusEmployeeCommandModel({
    required this.id,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
