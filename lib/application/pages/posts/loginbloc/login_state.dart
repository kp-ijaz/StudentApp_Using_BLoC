part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginCheckingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState({required this.error});
}
