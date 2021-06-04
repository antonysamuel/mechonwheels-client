import 'package:flutter/material.dart';
import 'package:mechonwheelz/pages/splashscreen.dart';
import 'package:mechonwheelz/services/providerClass.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateProvider(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
