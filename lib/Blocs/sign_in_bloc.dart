import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:testproject/Service/authentication.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is signInWithGoogle) {
      yield SignInLoading();

      String? result = await Authentication(FirebaseAuth.instance).signInWithGoogle();
      if (result != "true") {
        Flushbar(
          icon: const ImageIcon(
            AssetImage('assets/logo.jpg'),
            color: Colors.blueAccent,
          ),
          backgroundColor: Colors.transparent,
          barBlur: 05,
          flushbarStyle: FlushbarStyle.GROUNDED,
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(8),
          title: "TEST PROJE",
          message: result,
          duration: const Duration(seconds: 5),
        ).show(event.context);
        yield SignOut();
      }
      if (result == "true") {
        User user = Authentication(FirebaseAuth.instance).getUSer();
        yield SignInSuccesfull(user);
      }
    }
    if (event is signInEmail) {
      yield SignInLoading();
      String? result = await Authentication(FirebaseAuth.instance)
          .signIn(email: event.email, password: event.password);
      if (result != "true") {
        Flushbar(
          icon: const ImageIcon(
            AssetImage('assets/logo.jpg'),
            color: Colors.blueAccent,
          ),
          backgroundColor: Colors.transparent,
          barBlur: 05,
          flushbarStyle: FlushbarStyle.GROUNDED,
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(8),
          title: "TEST PROJE",
          message: result,
          duration: const Duration(seconds: 5),
        ).show(event.context);
        yield SignOut();
      }
      if (result == "true") {
        User user = Authentication(FirebaseAuth.instance).getUSer();
        yield SignInSuccesfull(user);
      }
    }
    if (event is signOut) {
      yield SignInLoading();
      await Authentication(FirebaseAuth.instance).signOut();
      yield SignOut();
    }
  }
}
