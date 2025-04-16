class ConfirmForgetPasswordCommand {
  final String email;
  final String code;

  ConfirmForgetPasswordCommand({
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
