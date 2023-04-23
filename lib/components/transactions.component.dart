import 'package:flutter/material.dart';
import 'package:isave/models/transaction.model.dart';
import 'package:isave/utils/currency.dart';
import 'package:styled_widget/styled_widget.dart';

class TransactionComponent extends StatelessWidget {
  const TransactionComponent({
    super.key,
    required this.transaction,
  });
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return <Widget>[
      <Widget>[
        Styled.text("₦${format(transaction.amount.toString())}")
            .fontSize(18)
            .fontWeight(FontWeight.w600)
            .textColor(Colors.white),
        Styled.text(
          "${transaction.time.day}-${transaction.time.month}-${transaction.time.year}",
        ).fontSize(12).textColor(Colors.white54),
      ]
          .toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .padding(vertical: 5),
      <Widget>[
        Styled.text(
          "Channel: ${transaction.source == TransactionSource.bank ? 'Bank' : 'Card'}",
        ).textColor(Colors.white60),
        Styled.text(
          transaction.type == TransactionType.credit ? 'Deposit' : 'Withdrawal',
        ).fontSize(10).textColor(Colors.white54),
      ]
          .toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .padding(vertical: 5),
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .padding(all: 10)
        .card(
          color: const Color.fromARGB(255, 6, 92, 203),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        )
        .padding(
          horizontal: 10,
        );
  }
}
