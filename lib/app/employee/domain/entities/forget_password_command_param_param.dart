class ForgetPasswordCommandParam {
  final String email;

  ForgetPasswordCommandParam({
    required this.email,
  });
  Map<String, dynamic> toJson() {
    return {

      'email': email,
    };
  }

}
