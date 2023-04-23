import 'package:flutter/material.dart';
import 'package:isave/components/transactions.component.dart';
import 'package:isave/models/transaction.model.dart';
import 'package:styled_widget/styled_widget.dart';

final transactions = <Transaction>[
  Transaction(
    amount: 20000,
    source: TransactionSource.bank,
    time: DateTime(2023, 1, 20),
  ),
  Transaction(
    amount: 50000,
    source: TransactionSource.bank,
    time: DateTime(2023, 1, 23),
  ),
  Transaction(
    amount: 80000,
    source: TransactionSource.bank,
    time: DateTime(2023, 2, 4),
  ),
];

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Styled.text("History").textColor(Colors.white).fontSize(15),
          backgroundColor: const Color.fromARGB(255, 6, 75, 168),
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(255, 6, 75, 168),
        body: SingleChildScrollView(
          child: transactions.reversed
              .map((e) => TransactionComponent(transaction: e))
              .toList()
              .toColumn()
              .scrollable(),
        ),
      ),
    );
  }
}
