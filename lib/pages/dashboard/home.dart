import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isave/bloc/auth.bloc.dart';
import 'package:isave/pages/transactions.dart';
import 'package:isave/utils/currency.dart';
import 'package:styled_widget/styled_widget.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, auth) => <Widget>[
        <Widget>[
          Styled.text("Hello, ")
              .textColor(Colors.white)
              .fontWeight(FontWeight.w600)
              .fontSize(18),
          Styled.text(auth.user!.name)
              .textColor(Colors.white)
              .fontWeight(FontWeight.w800)
              .fontSize(18),
        ].toRow().padding(horizontal: 25),
        <Widget>[
          <Widget>[
            <Widget>[
              Styled.text("Savings")
                  .fontSize(12)
                  .fontWeight(FontWeight.w300)
                  .textColor(Colors.white),
              Styled.text("₦${format((auth.balance ?? 0).toString())}")
                  .fontSize(30)
                  .fontWeight(FontWeight.w600)
                  .textColor(Colors.white),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            Styled.text("Tier 1")
                .fontSize(12)
                .fontWeight(FontWeight.w300)
                .textColor(Colors.white),
          ].toRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start),
          <Widget>[
            Styled.icon(Icons.add)
                .iconColor(Colors.white)
                .padding(all: 5)
                .ripple()
                .gestures(
                  onTap: () => context.read<AuthBloc>().setBalance(440000),
                )
                .backgroundColor(
                  const Color.fromARGB(255, 6, 75, 168),
                )
                .elevation(3)
                .clipOval(),
          ].toRow(),
        ]
            .toColumn(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .padding(all: 20)
            .ripple()
            .card(
              elevation: 3,
              color: const Color.fromARGB(255, 6, 92, 203),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )
            .gestures(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const TransactionPage(),
                ),
              ),
            )
            .height(150)
            .padding(horizontal: 20, vertical: 5),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          physics: const ClampingScrollPhysics(),
          childAspectRatio: 1.2,
          children: [
            _Card(
              header: Styled.text("DAILY SAVINGS")
                  .textColor(Colors.white)
                  .fontWeight(FontWeight.w700),
              content:
                  Styled.text("₦${format("50")}").textColor(Colors.white70),
            ),
            _Card(
              header: Styled.text("DAILY TRANSACTIONS")
                  .textColor(Colors.white)
                  .fontWeight(FontWeight.w700),
              content: Styled.text(
                      "₦${format("50")} \nAMOUNT: ₦${format("10")} \nCLEARED: \nDATE:")
                  .textColor(Colors.white70),
            ),
            _Card(
              header: Styled.text("MONTHLY TRANSACTIONS")
                  .textColor(Colors.white)
                  .fontWeight(FontWeight.w700),
              content: Styled.text(
                      "₦${format("150")} \nAMOUNT: ₦${format("10")} \nCLEARED: \nDATE:")
                  .textColor(Colors.white70),
            ),
            _Card(
              header: Styled.text("TOTAL SAVINGS")
                  .textColor(Colors.white)
                  .fontWeight(FontWeight.w700),
              content:
                  Styled.text("₦${format("3000")}").textColor(Colors.white70),
            ),
          ],
        ).height(300).padding(horizontal: 20),
      ].toColumn(),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.header,
    required this.content,
  });
  final Widget header;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return <Widget>[
      header.padding(vertical: 5),
      content.padding(vertical: 5),
    ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .padding(all: 10)
        .card(color: const Color.fromARGB(255, 6, 92, 203))
        .width(170);
  }
}
