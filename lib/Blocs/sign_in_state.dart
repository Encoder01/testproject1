part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccesfull extends SignInState {
  User user;
  SignInSuccesfull(this.user);
}

class SignInLoading extends SignInState {
  SignInLoading();
}

class SignOut extends SignInState {
  SignOut();
}
