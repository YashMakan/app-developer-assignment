import 'package:flutter/material.dart';
import 'package:gamezy/database/database.dart';
import 'package:gamezy/views/home_screen.dart';
import 'package:gamezy/views/login_screen.dart';

import '../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initiateCounter();
    super.initState();
  }

  initiateCounter() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HiveHelper.isUserLoggedIn()
                ? const HomeScreen()
                : const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().background.color(context),
      body: Center(
        child: Text(
          "G",
          style: TextStyle(fontSize: 100, fontWeight: FontWeight.w700, color: CustomColors().heading.color(context)),
        ),
      ),
    );
  }
}
