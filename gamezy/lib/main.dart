import 'package:flutter/material.dart';
import 'package:gamezy/views/home_screen.dart';
import 'package:gamezy/views/login_screen.dart';
import 'package:gamezy/views/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveBoxes.initialize();
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamezy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
