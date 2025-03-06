class AuthResponse {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isActive;
  final bool? isGuest;
  final String? token;

  AuthResponse(
      {
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.isActive,
        required this.isGuest,
        required this.token,
      });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        isActive: json['is_active'],
        isGuest: json['is_guest'],
        token: json['token']);
  }


}