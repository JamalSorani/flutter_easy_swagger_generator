class ForgetPasswordCommandModel {
  final String email;

  ForgetPasswordCommandModel({
    required this.email,
  });
  Map<String, dynamic> toJson() {
    return {

      'email': email,
    };
  }

}
