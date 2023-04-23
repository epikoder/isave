import 'package:flutter/material.dart';
import 'package:isave/components/button.component.dart';
import 'package:isave/utils/currency.dart';
import 'package:styled_widget/styled_widget.dart';

class DashboardSavings extends StatefulWidget {
  const DashboardSavings({super.key});

  @override
  DashboardSavingsState createState() => DashboardSavingsState();
}

class DashboardSavingsState extends State<DashboardSavings> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController message = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      <Widget>[
        <Widget>[
          Styled.text("Savings")
              .textColor(Colors.white)
              .fontWeight(FontWeight.w600)
              .fontSize(18),
          Styled.text("How much are you saving, select from dropdowm")
              .textColor(Colors.white70)
              .fontSize(15),
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .padding(vertical: 10)
      ].toRow(),
      _AmountWidget(
        controller: controller,
      ).padding(vertical: 20),
      Button(
        title: "Save now",
        bgColor: const Color.fromARGB(255, 6, 92, 203),
        width: 200,
        disabled: controller.text.isEmpty,
        useProgress: true,
        onTap: () async {
          await Future.delayed(const Duration(seconds: 3));
          message.text = 'Saving completed successfully';
          setState(() {});
        },
      ).padding(
        vertical: 30,
      ),
      Styled.text(message.text)
          .textAlignment(TextAlign.center)
          .textColor(Colors.white70)
          .padding(vertical: 20)
    ]
        .toColumn()
        .padding(horizontal: 20)
        .width(MediaQuery.of(context).size.width);
  }
}

class _AmountWidget extends StatefulWidget {
  const _AmountWidget({
    this.controller,
  });

  final TextEditingController? controller;
  @override
  _AmountWidgetState createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<_AmountWidget> {
  double? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: const TextStyle(color: Colors.white),
      hint: Styled.text("Select Amount").textColor(Colors.white),
      dropdownColor: const Color.fromARGB(255, 6, 92, 203),
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(10),
      value: value,
      items: List.generate(1000, (int index) => (index + 1) * 1.00)
          .map(
            (e) => DropdownMenuItem<double>(
              value: e,
              child: Styled.text(
                '₦${format(e.toString())}',
              ).padding(horizontal: 10),
            ),
          )
          .toList(),
      onChanged: (v) {
        setState(() => {value = v});
        if (widget.controller != null) {
          widget.controller!.text = v.toString();
        }
      },
    ).padding(horizontal: 20).backgroundColor(
          const Color.fromARGB(255, 6, 92, 203),
        );
  }
}
