import 'package:flutter/material.dart';
import 'package:gamezy/database/database.dart';
import 'home_screen/home_screen.dart';
import 'login_screen/login_screen.dart';

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
        child: GradientText(
          "G",
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w700,
              color: CustomColors().heading.color(context)),
          gradient: const LinearGradient(colors: <Color>[
            Colors.pink,
            Colors.pinkAccent,
            Colors.orangeAccent
          ], stops: [
            0.15,
            0.4,
            1
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    Key? key,
    required this.gradient,
    this.style,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
