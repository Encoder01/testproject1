import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/Blocs/sign_in_bloc.dart';
import 'package:testproject/Service/authentication.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool email = true;
  bool pass = true;
  String emailErr = "Must have a valid email address";
  String passErr = "Must be at least 6 character";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1643),
      body: Stack(children: [
        Positioned(bottom: 0, child: Image.asset("assets/signpage/Vector1.png")),
        Positioned(
            bottom: 0, right: 0, child: Image.asset("assets/signpage/Vector2.png")),
        Positioned(top: 0, right: 0, child: Image.asset("assets/signpage/Vector3.png")),
        Positioned(top: 0, right: 0, child: Image.asset("assets/signpage/Vector4.png")),
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 60.0, bottom: 20),
                  child: Center(
                    child: Text(
                      "Welcome Back!",
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: "Helvetica Neue",
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.circular(40.0)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () async {
                        BlocProvider.of<SignInBloc>(context)
                            .add(signInWithGoogle(context));
                      },
                      child: Center(
                        child: ListTile(
                          title: const Text(
                            "CONTINUE WITH GOOGLE",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica Neue",
                                fontSize: 15),
                          ),
                          leading: Image.asset(
                            "assets/signpage/google.png",
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Center(
                    child: Text(
                      "OR LOG IN WITH EMAIL",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Helvetica Neue",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        errorText: email ? null : emailErr,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                        filled: true,
                        fillColor: Colors.white,
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        hintText: 'Email address'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        errorText: pass ? null : passErr,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                        filled: true,
                        fillColor: Colors.white,
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        hintText: 'Enter secure password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: const Color(0xFF777BF1),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () async {
                        setState(() {
                          if (passwordController.text.length < 6) {
                            pass = false;
                          } else {
                            pass = true;
                          }
                          email = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);
                        });
                        if (email && pass) {
                          BlocProvider.of<SignInBloc>(context).add(signInEmail(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              context));
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
