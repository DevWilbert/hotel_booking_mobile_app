part of 'app_setting_bloc.dart';

@immutable
sealed class AppSettingEvent {}


final class CheckSession extends AppSettingEvent {}
