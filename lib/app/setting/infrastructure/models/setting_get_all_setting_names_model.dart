
class SettingGetAllSettingNamesModel {
  final String type;
  SettingGetAllSettingNamesModel({required this.type});
  factory SettingGetAllSettingNamesModel.fromJson(Map<String, dynamic> json) {
    return SettingGetAllSettingNamesModel(

      type: json["Type"] ,
    );
  }

}
