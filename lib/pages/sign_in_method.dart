import 'package:flutter/material.dart';
import 'package:isave/pages/login.dart';
import 'package:styled_widget/styled_widget.dart';

class SignInMethod extends StatelessWidget {
  const SignInMethod({super.key});

  void navToLogin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Styled.widget(
        child: Material(
      color: const Color.fromARGB(255, 6, 75, 168),
      child: <Widget>[
        Image.asset(
          'assets/images/logo.png',
          height: 200,
        ),
        Styled.text("I-SAVE")
            .fontSize(20)
            .fontWeight(FontWeight.w500)
            .textColor(Colors.redAccent),
        <Widget>[
          Styled.text("Mobile Service")
              .textColor(Colors.white)
              .padding(vertical: 5),
          Styled.text("Sign Up")
              .textColor(Colors.white)
              .fontWeight(FontWeight.bold)
              .fontSize(40),
          Styled.text("Continue with mail")
              .textColor(Colors.white)
              .padding(vertical: 5),
          Styled.widget(
                  child: <Widget>[
            Styled.icon(Icons.mail)
                .iconColor(Colors.redAccent)
                .padding(all: 5)
                .backgroundColor(Colors.white)
                .clipOval(),
            Styled.text("Continue with mail")
                .textColor(Colors.white)
                .textAlignment(TextAlign.center)
                .fontSize(16)
                .fontWeight(FontWeight.w700)
                .width(200),
          ]
                      .toRow()
                      .padding(vertical: 10, horizontal: 10)
                      .backgroundColor(Colors.redAccent)
                      .clipRRect(all: 30)
                      .width(300))
              .gestures(
            onTap: () => navToLogin(context),
          )
        ].toColumn(),
        <Widget>[
          // Styled.text("Powered By").padding(vertical: 10),
          // Image.asset(
          //   'assets/images/cbn.png',
          //   height: 50,
          // )
        ].toColumn()
      ]
          .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
          .padding(top: MediaQuery.of(context).size.height * .2, bottom: 20),
    ));
  }
}
