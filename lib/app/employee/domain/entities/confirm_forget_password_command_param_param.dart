class ConfirmForgetPasswordCommandParam {
  final String email;
  final String code;

  ConfirmForgetPasswordCommandParam({
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
