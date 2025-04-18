class RefreshTokenCommandParam {
  final String id;
  final String refreshtoken;

  RefreshTokenCommandParam({
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
