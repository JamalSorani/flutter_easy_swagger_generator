class ForgetPasswordCommand {
  final String email;

  ForgetPasswordCommand({
    required this.email,
  });
  Map<String, dynamic> toJson() {
    return {

      'email': email,
    };
  }

}
