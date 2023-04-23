import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isave/pages/dashboard/home.dart';
import 'package:isave/pages/dashboard/savings.dart';
import 'package:isave/pages/dashboard/withdraw.dart';
import 'package:styled_widget/styled_widget.dart';

class NavBloc extends Cubit<int> {
  NavBloc() : super(0);
  navigate(int state) => {emit(state)};
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Styled.widget(
      child: SafeArea(
        child: BlocProvider(
          create: (_) => NavBloc(),
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 6, 75, 168),
            appBar: AppBar(
              leading: Styled.icon(Icons.person)
                  .padding(all: 3)
                  .backgroundColor(const Color.fromARGB(255, 6, 92, 203))
                  .clipOval()
                  .padding(all: 5),
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 6, 75, 168),
            ),
            body: SingleChildScrollView(
              child: Material(
                color: const Color.fromARGB(255, 6, 75, 168),
                child: BlocBuilder<NavBloc, int>(
                  builder: (context, state) {
                    switch (state) {
                      case 1:
                        return const DashboardSavings();
                      case 2:
                        return const DashboardWithdrawal();
                      default:
                        return const DashboardHome();
                    }
                  },
                ),
              ),
            ),
            bottomNavigationBar: BlocBuilder<NavBloc, int>(
              builder: (context, state) => <Widget>[
                Styled.icon(Icons.home)
                    .iconSize(30)
                    .iconColor(Colors.white)
                    .padding(all: 5)
                    .backgroundColor(state == 0
                        ? const Color.fromARGB(255, 6, 75, 168)
                        : Colors.transparent)
                    .ripple()
                    .clipOval()
                    .gestures(
                      onTap: () => context.read<NavBloc>().navigate(0),
                    )
                    .padding(horizontal: 20),
                Styled.icon(Icons.monetization_on)
                    .iconSize(30)
                    .iconColor(Colors.white)
                    .padding(all: 5)
                    .backgroundColor(state == 1
                        ? const Color.fromARGB(255, 6, 75, 168)
                        : Colors.transparent)
                    .ripple()
                    .clipOval()
                    .gestures(
                      onTap: () => context.read<NavBloc>().navigate(1),
                    )
                    .padding(horizontal: 20),
                Styled.icon(Icons.wallet)
                    .iconSize(30)
                    .iconColor(Colors.white)
                    .padding(all: 5)
                    .backgroundColor(state == 2
                        ? const Color.fromARGB(255, 6, 75, 168)
                        : Colors.transparent)
                    .ripple()
                    .clipOval()
                    .gestures(
                      onTap: () => context.read<NavBloc>().navigate(2),
                    )
                    .padding(horizontal: 20),
              ]
                  .toRow(mainAxisAlignment: MainAxisAlignment.center)
                  .padding(vertical: 5)
                  .backgroundColor(const Color.fromARGB(255, 6, 92, 203))
                  .elevation(3),
            ),
          ),
        ),
      ),
    );
  }
}
