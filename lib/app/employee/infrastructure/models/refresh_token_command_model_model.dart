class RefreshTokenCommandModel {
  final String id;
  final String refreshtoken;

  RefreshTokenCommandModel({
    required this.id,
    required this.refreshtoken,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'refreshToken': refreshtoken,
    };
  }

}
