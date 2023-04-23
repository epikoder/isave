import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isave/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  User? user;
  double? balance;
}

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState());

  Future<void> login(User user) async {
    var pref = await SharedPreferences.getInstance();
    var balance = pref.getDouble("user.balance");
    if (balance == null || balance == 0) {
      balance = 440000;
      await pref.setDouble("user.balance", balance);
    }
    emit(
      AuthState()
        ..user = user
        ..balance = balance,
    );
  }

  Future<void> setBalance(double balance) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setDouble("user.balance", balance);
    emit(
      AuthState()
        ..user = state.user
        ..balance = balance,
    );
  }
}
