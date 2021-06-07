import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mechonwheelz/pages/home.dart';
import 'package:mechonwheelz/services/models.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';

class StateProvider with ChangeNotifier {
  String url = "10.0.3.2:8000";
  String token = "";

/////////////////Login Register Logic/////////////////////////////////
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  String emailText = "";
  String usernameText = "";
  String passwordText = "";
  String password2Text = "";

  String authErr = "";

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

  bool locService = true;
  bool refetch = true;

  double lat = 0, lon = 0;

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

  void loginUser(BuildContext ctx) async {
    if (!loginIsValid || usernameText.isEmpty || passwordText.isEmpty) {
      print("Invalid credentials");
      return;
    }
    print('Username: $usernameText\nPassword: $passwordText');
    try {
      final response = await http.post(Uri.http(url, 'login/'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'username': usernameText,
            'password': passwordText,
          }));
      final storage = new FlutterSecureStorage();
      var data = jsonDecode(response.body);
      if (data.containsKey("err")) {
        print(data['err']);
        authErr = data['err'];
        notifyListeners();
        return;
      }
      authErr = "";
      token = data['token'];
      await storage.write(key: 'token', value: token);
      Navigator.pushReplacement(ctx,
          PageTransition(child: HomePage(), type: PageTransitionType.fade));
    } catch (e) {
      print(e);
    }
  }

  void registerUser(BuildContext ctx) async {
    if (!loginIsValid ||
        usernameText.isEmpty ||
        passwordText.isEmpty ||
        emailText.isEmpty ||
        password2Text.isEmpty) {
      print("Invalid credentials");
      return;
    }
    print('Username: $usernameText\nPassword: $passwordText');
    final response = await http.post(Uri.http(url, 'register/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': usernameText,
          'email': emailText,
          'password': passwordText,
          'password2': password2Text
        }));
    var data = jsonDecode(response.body);
    if (data.containsKey("username")) {
      print(data['username'][0]);
      authErr = data['username'][0];
      notifyListeners();
      return;
    }
    authErr = "";
    print(data['token']);
    token = data['token'];
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: token);

    Navigator.pushReplacement(
        ctx, PageTransition(child: HomePage(), type: PageTransitionType.fade));
  }

  ///////////////////////////////////////////////////////////////////////////////

  String userName = "Arjun";

  //////////////////////WorkshopList///////////////////

  Set<Marker> markers = {};
  int _idx = 0;

  List<Workshops> workshops = [];
  String urln = "http://10.0.3.2:8000/nearby/";
  final dio = Dio();
  void fetchWorkshops() async {
    if (workshops.isNotEmpty || !refetch) {
      return;
    }

    try {
      Position position = await fetchLocation();
      // print("Location");
      // print(position.latitude);
      // print(position.longitude);
      lat = position.latitude;
      lon = position.longitude;
      markers.add(
          Marker(markerId: MarkerId('${_idx++}'), position: LatLng(lat, lon)));

      dio.options.headers['Authorization'] = "Token $token";
      dio.options.followRedirects = false;
      final response = await dio.post(urln, data: {"lat": lat, "lon": lon});
      refetch = false;
      print(response.statusCode);

      // print(response);
      for (var items in response.data) {
        workshops.add(Workshops(
            items['workshopName'],
            items['address'],
            items['phone'],
            double.parse(items['latitude']),
            double.parse(items['longitude'])));

        // ploting on map
        markers.add(Marker(
            markerId: MarkerId('${_idx++}'),
            position: LatLng(double.parse(items['latitude']),
                double.parse(items['longitude']))));
      }
      // print(workshops);

    } on DioError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<Position> fetchLocation() async {
    print("Fetching......");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    // print("Lat: ${position.latitude}\nLon: ${position.longitude}");
    return position;
  }

  /////////////////////////findWorkshops////////////////////////////
  String searchUrl = "http://10.0.3.2:8000/search/?query=";
  List<Workshops> findWorkshopList = [];
  void searchWorkshop(String searchTxt) async {
    if (findWorkshopList.isNotEmpty) {
      findWorkshopList.clear();
    }
    final response = await dio.get(searchUrl + searchTxt);

    for (var items in response.data) {
      findWorkshopList.add(Workshops(
          items['workshopName'],
          items['address'],
          items['phone'],
          double.parse(items['latitude']),
          double.parse(items['longitude'])));
    }
    notifyListeners();
  }

  void clearWorkshopList() {
    findWorkshopList.clear();
    notifyListeners();
  }
}

class ValidationService {
  final String value;
  final String error;
  ValidationService(this.value, this.error);
}
