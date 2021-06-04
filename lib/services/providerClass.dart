import 'package:flutter/material.dart';

class StateProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  String emailText = "";
  String usernameText = "";
  String passwordText = "";
  String password2Text = "";

  String emailError = "";
  String usernameError = "";
  String passwordError = "";
  String password2Error = "";

  ValidationService emailValidation = ValidationService("null", "null");
  ValidationService usernameValidation = ValidationService("null", "null");
  ValidationService passwordValidation = ValidationService("null", "null");
  ValidationService password2Validation = ValidationService("null", "null");

  bool loginIsValid = true;
  bool siunUpIsValid = true;

  void loadValues() {
    usernameText = usernameController.text;
    passwordText = passwordController.text;
  }

  void validateUsername(String value) {
    if (value.length <= 3) {
      usernameValidation = ValidationService("null", "Invalid username");
      loginIsValid = false;
    } else {
      usernameValidation = ValidationService(value, "null");
      loginIsValid = true;
    }
    notifyListeners();
  }

  void validateEmail(String value) {
    if (value.length <= 5 || !value.contains('@') || !value.contains('.')) {
      emailValidation = ValidationService("null", "Enter a valid emaiil");
      loginIsValid = false;
    } else {
      emailValidation = ValidationService(value, "null");
      loginIsValid = true;
    }
    notifyListeners();
  }

  void validatePassword(String value) {
    if (value.length <= 6) {
      passwordValidation =
          ValidationService("null", "Minimun password length is 6");
      loginIsValid = false;
    } else {
      passwordValidation = ValidationService(value, "null");
      loginIsValid = true;
    }
    notifyListeners();
  }

  void validatePassword2(String value) {
    if (value != passwordText) {
      password2Validation =
          ValidationService("null", "Passwords does not match");
      loginIsValid = false;
    } else {
      password2Validation = ValidationService(value, "null");
      loginIsValid = true;
    }
    notifyListeners();
  }

  void loginUser() {
    if (!loginIsValid) {
      print("Invalid credentials");
      return;
    }
    print('Username: $usernameText\nPassword: $passwordText');
  }
  void registerUser() {
    if (!loginIsValid) {
      print("Invalid credentials");
      return;
    }
    print('Username: $usernameText\nPassword: $passwordText');
  }
}

class ValidationService {
  final String value;
  final String error;
  ValidationService(this.value, this.error);
}
