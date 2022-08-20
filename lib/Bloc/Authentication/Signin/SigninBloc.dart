import 'package:rxdart/rxdart.dart';

class SignInBloc {
  final BehaviorSubject<bool> _is_loading = BehaviorSubject<bool>();
  Stream<bool> get is_loading => _is_loading.stream;

  final BehaviorSubject<bool> _obscure_text = BehaviorSubject<bool>();
  Stream<bool> get obscure_text => _obscure_text.stream;
  // ignore: non_constant_identifier_names
  void updateLoading(bool value) {
    _is_loading.value = value;
    _is_loading.sink;
  }

  void updateObscure(bool value) {
    _obscure_text.value = value;
    _obscure_text.sink;
  }
}

// ignore: non_constant_identifier_names
SignInBloc signInBloc = SignInBloc();
