import 'package:flutter/material.dart';
import 'package:isave/pages/sign_in_method.dart';
import 'package:styled_widget/styled_widget.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});
  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SignInMethod(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Styled.widget(
        child: Material(
      child: <Widget>[
        Image.asset(
          'assets/images/logo.png',
          height: 200,
        ),
        Styled.text("I-SAVE")
            .fontSize(50)
            .fontWeight(FontWeight.w500)
            .textColor(Colors.white),
        <Widget>[
          // Styled.text("Powered By")
          //     .textColor(Colors.white)
          //     .padding(vertical: 10),
          // Image.asset(
          //   'assets/images/cbn.png',
          //   height: 50,
          // )
        ].toColumn()
      ]
          .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
          .padding(top: MediaQuery.of(context).size.height * .4, bottom: 20)
          .backgroundColor(const Color.fromARGB(255, 6, 75, 168)),
    ));
  }
}
