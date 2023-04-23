import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.title,
    required this.onTap,
    this.useProgress = false,
    this.bgColor = Colors.redAccent,
    this.width = 300,
    this.disabled = false,
  });
  final String title;
  final Future<void> Function()? onTap;
  final bool useProgress;
  final Color bgColor;
  final double width;
  final bool disabled;

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> {
  bool isLoading = false;

  Future<void> onTap() async {
    if (mounted && widget.useProgress) {
      setState(() {
        isLoading = true;
      });
    }
    if (widget.onTap != null) {
      await widget.onTap!();
    }
    if (mounted && widget.useProgress) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Styled.widget(
            child: <Widget>[
      widget.useProgress && isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            ).width(20).height(20).padding(horizontal: 10)
          : const SizedBox(),
      Styled.text(widget.title)
          .textColor(Colors.white)
          .fontWeight(FontWeight.w600)
          .fontSize(18)
    ].toRow(mainAxisAlignment: MainAxisAlignment.center))
        .padding(vertical: 10, horizontal: 20)
        .ripple()
        .backgroundColor(
          isLoading || widget.disabled ? Colors.grey : widget.bgColor,
        )
        .gestures(
          onTap: isLoading || widget.disabled ? () => {} : onTap,
        )
        .elevation(3)
        .clipRRect(all: 10)
        .width(widget.width);
  }
}
