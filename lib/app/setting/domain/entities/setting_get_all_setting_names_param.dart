
class SettingGetAllSettingNamesParam {
  final String type;
  SettingGetAllSettingNamesParam({required this.type});
  Map<String, dynamic> toJson() {
    return {

      'Type': type,
    };
  }

}
