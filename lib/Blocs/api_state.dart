part of 'api_bloc.dart';

@immutable
abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  UserModel users;
  ApiLoaded(this.users);
}

class ApiError extends ApiState {}
