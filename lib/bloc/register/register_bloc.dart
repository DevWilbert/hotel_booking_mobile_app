import 'package:bloc/bloc.dart';
import 'package:hotel_app/params/register_param.dart';
import 'package:hotel_app/repo/register_repository.dart';
import 'package:hotel_app/response/register_response.dart';
import 'package:meta/meta.dart';

import '../../core/api_exception.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final registerRepository = RegisterRepository();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterPressed>(_onRegisterPressed);
    on<RegisterReset>(_onRegisterReset);
  }

  void _onRegisterPressed(RegisterPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final param = RegisterParam(
          username: event.param.username,
          email: event.param.email,
          password1: event.param.password1,
          password2: event.param.password2,
          firstName: event.param.firstName,
          lastName: event.param.lastName,
      );
      RegisterResponse response = await registerRepository.register(param);
      emit(RegisterSuccess(registerResponse: response));

    } on ApiException catch(apiException) {
      emit(RegisterError(message: apiException.toString()));
    } catch(e) {
      emit(RegisterFatalError(message: e.toString()));
    }
  }

  void _onRegisterReset(RegisterReset event, Emitter<RegisterState> emit) {
    emit(RegisterInitial());
  }
}
