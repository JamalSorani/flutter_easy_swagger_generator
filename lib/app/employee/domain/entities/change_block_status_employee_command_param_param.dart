class ChangeBlockStatusEmployeeCommandParam {
  final String id;

  ChangeBlockStatusEmployeeCommandParam({
    required this.id,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
