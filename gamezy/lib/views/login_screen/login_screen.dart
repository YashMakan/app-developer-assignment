import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezy/api/api.dart';
import 'package:gamezy/constants/colors.dart';
import 'dart:math' as math;
import 'package:gamezy/constants/homescreen_images.dart';
import 'package:gamezy/database/database.dart';
import 'package:gamezy/models/user.dart';
import 'package:gamezy/utils/global_param.dart';
import 'package:gamezy/utils/utils.dart';
import 'package:gamezy/views/home_screen/home_screen.dart';
import 'package:gamezy/widgets/common_widgets.dart';

import 'login_screen_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  late TextEditingController controller1;
  late TextEditingController controller2;

  bool _passwordHidden = true;

  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;
      double minScrollExtent3 = _scrollController3.position.minScrollExtent;
      double maxScrollExtent3 = _scrollController3.position.maxScrollExtent;

      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 25,
          _scrollController1);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 15,
          _scrollController2);
      animateToMaxMin(maxScrollExtent3, minScrollExtent3, maxScrollExtent3, 20,
          _scrollController3);
    });
    super.initState();
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: CustomColors().background.color(context),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 60,
              left: -70,
              child: Transform.rotate(
                angle: math.pi * -0.08,
                child: Opacity(
                  opacity:
                      MediaQuery.of(context).viewInsets.bottom == 0 ? 1 : 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width + 100,
                    child: Column(
                      children: [
                        GameListView(
                          scrollController: _scrollController1,
                          images: section1,
                        ),
                        GameListView(
                          scrollController: _scrollController2,
                          images: section2,
                        ),
                        GameListView(
                          scrollController: _scrollController3,
                          images: section3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Sign in.",
                  style: TextStyle(
                      fontSize: 34,
                      color: CustomColors().heading.color(context),
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 30,
                ),
                thirdPartyLoginButton(
                    text: "Continue with Google",
                    icon: FontAwesomeIcons.google,
                    context: context),
                const SizedBox(
                  height: 15,
                ),
//              thirdPartyLoginButton(
//                  text: "Continue with Facebook",
//                  icon: FontAwesomeIcons.facebook),
//              const SizedBox(
//                height: 15,
//              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 1,
                      color: CustomColors()
                          .heading
                          .color(context)
                          .withOpacity(0.2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or",
                        style: TextStyle(
                            color: CustomColors()
                                .heading
                                .color(context)
                                .withOpacity(0.8),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 1,
                      color: CustomColors()
                          .heading
                          .color(context)
                          .withOpacity(0.2),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                customTextField(
                    text: "username",
                    context: context,
                    setState: setState,
                    controller: controller1),
                const SizedBox(
                  height: 15,
                ),
                customTextField(
                    text: "password",
                    context: context,
                    controller: controller2,
                    obscure: _passwordHidden,
                    onEyeClicked: () {
                      setState(() {
                        _passwordHidden = !_passwordHidden;
                      });
                    },
                    setState: setState),
                const SizedBox(
                  height: 30,
                ),
                submitButton(
                    text: "Sign in",
                    context: context,
                    isClickable: isClickable(),
                    onTap: onSubmitClicked),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onSubmitClicked() async {
    if (isClickable()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
                child: GWidgets.loader(),
                onWillPop: () {
                  return Future.value(false);
                });
          });
      User? user = await Api.loginUser(
          username: controller1.text,
          password: controller2.text,
          context: context,
          uId: GlobalParam().udId);
      Navigator.pop(context);
      if (user?.cuId != null) {
        HiveHelper.updateUserDetails(user);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Utils.customFlushBar(
            context, ToastType.error, "Contact admin to create account");
      }
    } else {
      Utils.customFlushBar(context, ToastType.warning, "Invalid data passed");
    }
  }

  bool isClickable() =>
      errorText(controller1.text) == null &&
      errorText(controller2.text) == null &&
      controller1.text.isNotEmpty &&
      controller2.text.isNotEmpty;
}
