import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:testproject/Models/user_model.dart';
import 'package:testproject/Service/api_service.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial());

  @override
  Stream<ApiState> mapEventToState(
    ApiEvent event,
  ) async* {
    if (event is FetchApiData) {
      yield ApiLoading();
      try {
        UserModel users = await ApiService().getUsers(event.query);
        yield ApiLoaded(users);
      } on Exception catch (e) {
        yield ApiError();
      }
    }
  }
}
