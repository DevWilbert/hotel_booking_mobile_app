part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterPressed extends RegisterEvent {
  final RegisterParam param;
  RegisterPressed({required this.param});
}

final class RegisterReset extends RegisterEvent {}


