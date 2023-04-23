// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isave/bloc/auth.bloc.dart';
import 'package:isave/components/button.component.dart';
import 'package:isave/components/input.component.dart';
import 'package:isave/utils/currency.dart';
import 'package:isave/utils/validator.dart';
import 'package:styled_widget/styled_widget.dart';

class DashboardWithdrawal extends StatefulWidget {
  const DashboardWithdrawal({super.key});
  @override
  DashboardWithdrawalState createState() => DashboardWithdrawalState();
}

class DashboardWithdrawalState extends State<DashboardWithdrawal> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accController = TextEditingController();
  final TextEditingController message = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      setState(() {});
    });
    bankController.addListener(() {
      setState(() {});
    });
    accController.addListener(() {
      setState(() {});
    });
    nameController.addListener(() {
      setState(() {});
    });
  }

  String? _validateAmount(String? value, double balance) {
    if (value!.isEmpty) return null;
    var i = numberValidator(value);
    if (i != null) return i;
    var amount = double.tryParse(value);
    if (amount == null) return "invalid amount";
    return amount > balance ? "invalid" : null;
  }

  bool _isDisabled() {
    var amount = double.tryParse(amountController.text);
    return amount == null ||
        amount == 0 ||
        bankController.text.isEmpty ||
        accController.text.isEmpty ||
        nameController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, auth) => <Widget>[
        <Widget>[
          Styled.text("Withdrawal")
              .textColor(Colors.white)
              .fontWeight(FontWeight.w600)
              .fontSize(18),
        ].toRow().padding(horizontal: 25),
        <Widget>[
          <Widget>[
            <Widget>[
              Styled.text("Available for withdrawal")
                  .fontSize(12)
                  .fontWeight(FontWeight.w300)
                  .textColor(Colors.white),
              Styled.text("₦${format((auth.balance ?? 0).toString())}")
                  .fontSize(30)
                  .fontWeight(FontWeight.w600)
                  .textColor(Colors.white),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            Styled.text("Account: Tier 1")
                .fontSize(12)
                .fontWeight(FontWeight.w300)
                .textColor(Colors.white),
          ].toRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start),
        ]
            .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .padding(all: 20)
            .card(
              elevation: 3,
              color: const Color.fromARGB(255, 6, 92, 203),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )
            .height(100)
            .padding(vertical: 5),
        <Widget>[
          InputField(
            label: "Enter Amount",
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => _validateAmount(value, auth.balance ?? 0),
            controller: amountController,
          ),
          <Widget>[
            Styled.text(_validateAmount(
                            amountController.text, auth.balance ?? 0) ==
                        null
                    ? '₦${format(amountController.text.isEmpty ? 0.toString() : amountController.text)}'
                    : "")
                .textColor(Colors.white)
                .fontSize(14)
                .fontWeight(FontWeight.bold)
                .padding(
                  horizontal: 30,
                )
          ].toRow(),
          InputField(
            label: "Bank Name",
            placeholder: "First Bank",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: nameValidator,
            controller: bankController,
          ),
          InputField(
            label: "Name",
            placeholder: "Bank Account name",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: nameValidator,
            controller: nameController,
          ),
          InputField(
            label: "Account Number",
            placeholder: "Bank Account number",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: numberValidator,
            controller: accController,
          ),
          Button(
            title: "Withdraw",
            width: 200,
            bgColor: const Color.fromARGB(255, 6, 75, 168),
            useProgress: true,
            disabled:
                _validateAmount(amountController.text, auth.balance ?? 0) !=
                        null ||
                    _isDisabled(),
            onTap: () async {
              var bal = double.tryParse(amountController.text);
              if (bal == null) return;
              await Future.delayed(const Duration(seconds: 3));
              amountController.text = '';
              message.text =
                  'Withdrawal request successful, \nrequest will be processed withing 1-24 hours';
              setState(() {});
              context.read<AuthBloc>().setBalance(auth.balance! - bal);
            },
          ).padding(vertical: 10),
          Styled.text(message.text)
              .textAlignment(TextAlign.center)
              .textColor(Colors.white70)
              .padding(vertical: 10)
        ]
            .toColumn()
            .padding(vertical: 10)
            .card(
              elevation: 3,
              color: const Color.fromARGB(255, 6, 92, 203),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )
            .padding(vertical: 20),
      ].toColumn().padding(
            horizontal: 20,
          ),
    );
  }
}
