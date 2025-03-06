import 'package:hive/hive.dart';

class SessionManager {
  final Box box = Hive.box('session');

  void setSession(String token, int id, String firstName, String lastName, String email) {
    box.put(AppKey.tokenKey, token);
    box.put(AppKey.idKey, id);
    box.put(AppKey.firstNameKey, firstName);
    box.put(AppKey.lastNameKey, lastName);
    box.put(AppKey.emailKey, email);
  }

  String? getActiveToken() => box.get(AppKey.tokenKey);
  int? getActiveId() => box.get(AppKey.idKey);
  String? getActiveFirstName() => box.get(AppKey.firstNameKey);
  String? getActiveLastName() => box.get(AppKey.lastNameKey);
  String? getActiveEmail() => box.get(AppKey.emailKey);

  bool activeSession() {
    String? activeToken = getActiveToken();
    int? activeId = getActiveId();
    String? activeFirstName = getActiveFirstName();
    String? activeLastName =getActiveLastName();
    String? activeEmail = getActiveEmail();

    return activeToken != null && activeId != null && activeFirstName != null && activeLastName != null && activeEmail != null;
  }

  void signOut() {
    box.delete(AppKey.tokenKey);
    box.delete(AppKey.idKey);
    box.delete(AppKey.firstNameKey);
    box.delete(AppKey.lastNameKey);
    box.delete(AppKey.emailKey);
  }
}

class AppKey {
  static const String tokenKey = 'TOKEN_KEY';
  static const String idKey = 'ID_KEY';
  static const String firstNameKey = 'FIRST_NAME_KEY';
  static const String lastNameKey = 'LAST_NAME_KEY';
  static const String emailKey = 'EMAIL_KEY';
}