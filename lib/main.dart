import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/Blocs/api_bloc.dart';
import 'package:testproject/Blocs/sign_in_bloc.dart';

import 'Pages/CustomerPAge/customer_page.dart';
import 'Pages/LoginPage/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInBloc(),
          ),
          BlocProvider(
            create: (context) => ApiBloc(),
          ),
        ],
        child: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          return const CustomerPage();
        } else {
          if (state is SignInSuccesfull) {
            if (state.user.uid != null) {
              return const CustomerPage();
            } else {
              return const SignIn();
            }
          } else {
            return const SignIn();
          }
        }
      },
    );
  }
}
