class ChangeBlockStatusEmployeeCommand {
  final String id;

  ChangeBlockStatusEmployeeCommand({
    required this.id,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
