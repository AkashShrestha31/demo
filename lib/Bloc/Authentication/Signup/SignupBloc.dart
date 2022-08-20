import 'package:rxdart/rxdart.dart';

class SignUpBloc {
  final BehaviorSubject<bool> _is_loading = BehaviorSubject<bool>();
  Stream<bool> get is_loading => _is_loading.stream;
  // ignore: non_constant_identifier_names
  void updateLoading(bool value) {
    _is_loading.value = value;
    _is_loading.sink;
  }
}

// ignore: non_constant_identifier_names
SignUpBloc signUpBloc = SignUpBloc();
