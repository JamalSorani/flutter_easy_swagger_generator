class RefreshTokenCommandModel {
  final String id;
  final String refreshtoken;

  RefreshTokenCommandModel({
    required this.id,
    required this.refreshtoken,
  });
  factory RefreshTokenCommandModel.fromJson(Map<String,dynamic>json){
  return RefreshTokenCommandModel(

      id : json["id"],
      refreshtoken : json["refreshToken"],
    );
  }

}
