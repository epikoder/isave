import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isave/components/button.component.dart';
import 'package:isave/components/input.component.dart';
import 'package:isave/utils/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

enum _SignupPhase { step1, step2 }

class _SignupData {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController kin = TextEditingController();
  TextEditingController bvn = TextEditingController();
  TextEditingController nin = TextEditingController();
  TextEditingController address = TextEditingController();
  _SignupPhase step = _SignupPhase.step1;
  Widget? message;
}

class _SignupBloc extends Cubit<_SignupData> {
  _SignupBloc() : super(_SignupData());

  Future<void> toStep1() {
    emit(
      _SignupData()
        ..address = state.address
        ..bvn = state.bvn
        ..email = state.email
        ..kin = state.kin
        ..name = state.name
        ..nin = state.nin
        ..password = state.password
        ..step = _SignupPhase.step1,
    );
    return Future.value();
  }

  Future<void> toStep2() {
    emit(
      _SignupData()
        ..address = state.address
        ..bvn = state.bvn
        ..email = state.email
        ..kin = state.kin
        ..name = state.name
        ..nin = state.nin
        ..password = state.password
        ..step = _SignupPhase.step2,
    );
    return Future.value();
  }

  Future<void> onSignup(BuildContext context) async {
    emit(
      _SignupData()
        ..address = state.address
        ..bvn = state.bvn
        ..email = state.email
        ..kin = state.kin
        ..name = state.name
        ..nin = state.nin
        ..password = state.password
        ..step = _SignupPhase.step2
        ..message = null,
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("user.name", state.name.text.trim());
    await pref.setString("user.email", state.email.text.trim().toLowerCase());
    await pref.setString("user.password", state.password.text.trim());
    await pref.setString("user.kin", state.kin.text.trim());
    await pref.setString("user.bvn", state.bvn.text.trim());
    await pref.setString("user.nin", state.nin.text.trim());
    await pref.setString("user.address", state.address.text.trim());
    emit(
      _SignupData()
        ..address = state.address
        ..bvn = state.bvn
        ..email = state.email
        ..kin = state.kin
        ..name = state.name
        ..nin = state.nin
        ..password = state.password
        ..step = _SignupPhase.step2
        ..message = Styled.text("Registration successful, login to continue")
            .textColor(Colors.blue),
    );
    return Future.value();
  }
}

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final GlobalKey<FormState> formKeyA = GlobalKey();
  final GlobalKey<FormState> formKeyB = GlobalKey();

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
                create: (context) => _SignupBloc(),
                child: BlocBuilder<_SignupBloc, _SignupData>(
                  builder: (context, data) => <Widget>[
                    <Widget>[Image.asset("assets/images/signup.png")]
                        .toRow()
                        .padding(bottom: 20),
                    data.message ?? const SizedBox(),
                    data.step == _SignupPhase.step1
                        ? Form(
                            key: formKeyA,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: <Widget>[
                              InputField(
                                label: 'Name',
                                placeholder: 'John Doe',
                                controller: data.name,
                                validator: (value) => nameValidator(value),
                              ),
                              InputField(
                                label: 'Email',
                                placeholder: 'johndoe@gmail.com',
                                controller: data.email,
                                validator: (value) => emailValidator(value),
                              ),
                              InputField(
                                label: 'Password',
                                placeholder: '********',
                                inputType: InputType.password,
                                controller: data.password,
                                validator: (value) => passwordValidator(value),
                              ),
                              InputField(
                                label: 'Next of Kin',
                                controller: data.kin,
                                validator: (value) => kinValidator(value),
                              ),
                              Button(
                                title: "Next",
                                onTap: () async {
                                  if (formKeyA.currentState!.validate()) {
                                    context.read<_SignupBloc>().toStep2();
                                  }
                                },
                              )
                            ].toColumn())
                        : const SizedBox(),
                    data.step == _SignupPhase.step2
                        ? Form(
                            key: formKeyB,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: <Widget>[
                              <Widget>[
                                Styled.icon(Icons.arrow_back)
                                    .iconColor(Colors.white)
                                    .padding(all: 5)
                                    .ripple()
                                    .backgroundColor(Colors.redAccent)
                                    .gestures(
                                      onTap: () =>
                                          context.read<_SignupBloc>().toStep1(),
                                    )
                                    .clipOval()
                                    .padding(horizontal: 20)
                              ].toRow(),
                              InputField(
                                label: 'BVN',
                                controller: data.bvn,
                                maxLenght: 11,
                                validator: (value) => bvnValidator(value),
                              ),
                              InputField(
                                label: 'NIN',
                                controller: data.nin,
                                maxLenght: 10,
                                validator: (value) => ninValidator(value),
                              ),
                              InputField(
                                label: 'Address',
                                placeholder: '',
                                controller: data.address,
                                validator: (value) => addressValidator(value),
                              ),
                              Button(
                                title: "SignUp",
                                useProgress: true,
                                onTap: () async {
                                  if (formKeyB.currentState!.validate()) {
                                    await context
                                        .read<_SignupBloc>()
                                        .onSignup(context);
                                  }
                                },
                              ),
                            ].toColumn(),
                          )
                        : const SizedBox(),
                    <Widget>[
                      Styled.text("Already have an account?")
                          .textColor(Colors.white)
                          .padding(vertical: 5),
                      Styled.text("Login here")
                          .textColor(Colors.white)
                          .padding(vertical: 5)
                          .gestures(
                            onTap: () => Navigator.of(context).pop(),
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
