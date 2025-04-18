class RefreshTokenCommand {
  final String id;
  final String refreshtoken;

  RefreshTokenCommand({
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
