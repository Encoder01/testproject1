part of 'api_bloc.dart';

@immutable
abstract class ApiEvent {}

class FetchApiData extends ApiEvent{
  String query;
  FetchApiData(this.query);
}