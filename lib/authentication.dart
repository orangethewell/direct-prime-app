import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _LoginUuid = "";

  String get LoginUuid => _LoginUuid;

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _LoginUuid = prefs.getString('LoginUuid') ?? "";
    notifyListeners();
  }

  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _LoginUuid = "random";
    await prefs.setString('LoginUuid', _LoginUuid);
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _LoginUuid = "";
    await prefs.remove('LoginUuid');
    notifyListeners();
  }
}