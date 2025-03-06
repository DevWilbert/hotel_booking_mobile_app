part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginPressed extends LoginEvent {
  final AuthParam param;
  LoginPressed({required this.param});
}

final class LoginReset extends LoginEvent {}
