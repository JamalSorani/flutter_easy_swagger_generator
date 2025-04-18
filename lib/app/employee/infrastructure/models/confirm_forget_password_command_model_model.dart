class ConfirmForgetPasswordCommandModel {
  final String email;
  final String code;

  ConfirmForgetPasswordCommandModel({
    required this.email,
    required this.code,
  });
  Map<String, dynamic> toJson() {
    return {

      'email': email,
      'code': code,
    };
  }

}
