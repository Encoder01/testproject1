part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class signInWithGoogle extends SignInEvent {
  BuildContext context;
  signInWithGoogle(this.context);
}

class signInEmail extends SignInEvent {
  BuildContext context;
  String email;
  String password;
  signInEmail(this.email, this.password, this.context);
}

class signOut extends SignInEvent {
  signOut();
}
