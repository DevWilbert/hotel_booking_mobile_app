class RegisterParam {
  final String? username;
  final String? email;
  final String? password1;
  final String? password2;
  final String? firstName;
  final String? lastName;

  RegisterParam(
      {
        required this.username,
        required this.email,
        required this.password1,
        required this.password2,
        required this.firstName,
        required this.lastName,
      });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password1': password1,
      'password2': password2,
      'first_name' : firstName,
      'last_name' : lastName,
      'is_guest' : 1,
      'is_active' : 1,
    };
  }

}