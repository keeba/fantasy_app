import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering,
  RegistrationFailed,
  Registered
}

class UserRepository extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  FirebaseUser _user;
  UserStatus _status = UserStatus.Uninitialized;
  String _message;

  UserRepository() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  UserStatus get status => _status;
  FirebaseUser get user => _user;
  String get errorMessage => _message;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = UserStatus.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = UserStatus.Unauthenticated;
      notifyListeners();
      _message = e.toString();
      if (_message.contains('ERROR_USER_NOT_FOUND')) {
        _message =
            'There is no user record corresponding to this identifier. The user may have been deleted.';
      } else if (_message.contains('ERROR_INVALID_EMAIL')) {
        _message = 'The email address is badly formatted';
      } else if (_message.contains('ERROR_WRONG_PASSWORD')) {
        _message =
            'The password is invalid or the user does not have a password.';
      } else if (_message.contains('ERROR_WEAK_PASSWORD')) {
        _message =
            'The given password is invalid. [ Password should be at least 6 characters ]';
      } else if (_message.contains('ERROR_TOO_MANY_REQUESTS')) {
        _message =
            'We have blocked all requests from this device due to unusual activity. Try again later. [ Too many unsuccessful login attempts. Please try again later.';
      }
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = UserStatus.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = UserStatus.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = UserStatus.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> register(_email, _password, _teamName) async {
    try {
      _status = UserStatus.Registering;
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      updateUserInfo(_email, _teamName);
      return true;
    } catch (e) {
      _status = UserStatus.RegistrationFailed;
      _message = e.toString();
      if (_message.contains('ERROR_EMAIL_ALREADY_IN_USE')) {
        _message = 'The email address is already in use by another account.';
      } else if (_message.contains('ERROR_INVALID_EMAIL')) {
        _message = 'The email address is badly formatted';
      } else if (_message.contains('ERROR_WEAK_PASSWORD')) {
        _message =
            'The given password is invalid. [ Password should be at least 6 characters ]';
      }
      return false;
    }
  }

  Future<void> updateUserInfo(_email, _teamName) async {
    DocumentSnapshot configDS =
        await _db.collection('configurations').document('configurations').get();

    await _db.collection('users').document(_email).setData(
      {
        'transfers_total': configDS['phase_transfers'],
        'transfers_left': configDS['phase_transfers'],
        'team_name': _teamName,
      },
    );
  }
}
