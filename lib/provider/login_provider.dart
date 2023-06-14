import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rpl_b/utils/result_state.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  String _message = '';

  ResultState _state = ResultState.initialState;

  ResultState get state => _state;

  String get message => _message;

  // * do login with email and password
  Future loginWithEmailPassword(String email, String password) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _state = ResultState.hasData;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _state = ResultState.error;
      _message = e.message!;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
