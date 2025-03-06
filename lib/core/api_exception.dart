// Class untuk menagani error response dalam bentuk list

class ApiException {
  final String message;

  ApiException({required this.message});

  String toString() {
    return message;
  }
}