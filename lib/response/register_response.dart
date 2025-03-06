class RegisterResponse {
  final String? message;
  final String? username;
  final String? password;
  final String? email;
  final String? firstName;
  final String? lastName;
  final bool? isActive;
  final bool? isGuest;

  RegisterResponse(
    {
        required this.message,
        required this.username,
        required this.password,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.isActive,
        required this.isGuest,
    }
  );

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        message: json['message'],
        username: json['data']['username'],
        password: json['data']['password'],
        email: json['data']['email'],
        firstName: json['data']['first_name'],
        lastName: json['data']['last_name'],
        isActive: json['data']['is_active'],
        isGuest: json['data']['is_guest'],
    );
  }
}
