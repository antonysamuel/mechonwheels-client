import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mechonwheelz/pages/splashscreen.dart';
import 'package:mechonwheelz/services/providerClass.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProv;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await pathProv.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  await Hive.openBox('tokenBox');

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
