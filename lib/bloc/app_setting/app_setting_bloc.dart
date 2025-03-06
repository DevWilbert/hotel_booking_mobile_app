import 'package:bloc/bloc.dart';
import 'package:hotel_app/core/session_manager.dart';
import 'package:meta/meta.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  final sessionManager = SessionManager();
  AppSettingBloc() : super(AppSettingInitial()) {
    on<CheckSession>(_checkSession);
  }

  void _checkSession(CheckSession event, Emitter<AppSettingState> emit) {
    sessionManager.activeSession()
        ? emit(AppSettingAuthenticated())
        : emit(AppSettingUnAuthenticated());
  }

}
