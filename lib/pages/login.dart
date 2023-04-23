// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isave/bloc/auth.bloc.dart';
import 'package:isave/components/button.component.dart';
import 'package:isave/components/input.component.dart';
import 'package:isave/models/user.model.dart';
import 'package:isave/pages/dashboard.dart';
import 'package:isave/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

class _LoginData {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget? message;
}

class _LoginBloc extends Cubit<_LoginData> {
  _LoginBloc() : super(_LoginData());

  Future<void> onLogin(BuildContext context) async {
    emit(
      _LoginData()
        ..email = state.email
        ..password = state.password
        ..message = null,
    );
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("user.email");
    var password = pref.getString("user.password");
    if (email != state.email.text && password != state.password.text) {
      emit(
        _LoginData()
          ..email = state.email
          ..password = state.password
          ..message = Styled.text(
            "invalid username or password",
          ).textColor(Colors.red),
      );
      return Future.value();
    }
    await context.read<AuthBloc>().login(
          User(name: pref.getString("user.name") ?? "Guest"),
        );
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const DashboardPage(),
    ));
    return Future.value();
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Styled.widget(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 6, 75, 168),
          body: SingleChildScrollView(
            child: Material(
              color: const Color.fromARGB(255, 6, 75, 168),
              child: BlocProvider(
                create: (context) => _LoginBloc(),
                child: BlocBuilder<_LoginBloc, _LoginData>(
                  builder: (context, data) => <Widget>[
                    <Widget>[Image.asset("assets/images/login.png")]
                        .toRow()
                        .padding(bottom: 20),
                    <Widget>[
                      data.message ?? const SizedBox(),
                      InputField(
                        label: 'Email',
                        placeholder: 'johndoe@gmail.com',
                        controller: data.email,
                      ),
                      InputField(
                        label: 'Password',
                        placeholder: '********',
                        inputType: InputType.password,
                        controller: data.password,
                      ),
                      Button(
                        title: "Login",
                        onTap: () =>
                            context.read<_LoginBloc>().onLogin(context),
                        useProgress: true,
                      ),
                      Styled.text("Don't have an account?")
                          .textColor(Colors.white)
                          .padding(vertical: 5),
                      Styled.text("Signup here")
                          .textColor(Colors.white)
                          .padding(vertical: 5)
                          .gestures(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            ),
                          )
                    ].toColumn(),
                    const SizedBox(),
                  ]
                      .toColumn(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                      .padding(bottom: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
