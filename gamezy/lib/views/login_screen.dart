import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezy/constants/colors.dart';
import 'dart:math' as math;
import 'package:gamezy/constants/homescreen_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                opacity: MediaQuery.of(context).viewInsets.bottom==0?1:0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width + 100,
                  child: Column(
                    children: [
                      MoviesListView(
                        scrollController: _scrollController1,
                        images: section1,
                      ),
                      MoviesListView(
                        scrollController: _scrollController2,
                        images: section2,
                      ),
                      MoviesListView(
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
                  text: "Continue with Google", icon: FontAwesomeIcons.google),
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
                    color:
                        CustomColors().heading.color(context).withOpacity(0.2),
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
                    color:
                        CustomColors().heading.color(context).withOpacity(0.2),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              customTextField(text: "username"),
              const SizedBox(
                height: 15,
              ),
              customTextField(text: "password"),
              const SizedBox(
                height: 30,
              ),
              submitButton(text: "Sign in"),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customTextField({required String text}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          border: Border.all(
              color: CustomColors().heading.color(context), width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: TextField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: text,
          contentPadding:
              const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ),
      ),
    );
  }

  Widget submitButton({required String text}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 45,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(colors: <Color>[
          Colors.pink,
          Colors.pinkAccent,
          Colors.orangeAccent
        ], stops: [
          0.15,
          0.4,
          1
        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
      child: Center(
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget thirdPartyLoginButton({required String text, required IconData icon}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          border: Border.all(
              color: CustomColors().heading.color(context), width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: CustomColors().heading.color(context), size: 15),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(
                  color: CustomColors().heading.color(context),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatefulWidget {
  const GradientIcon(this.icon, this.size, this.gradient, {Key? key})
      : super(key: key);

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  State<GradientIcon> createState() => _GradientIconState();
}

class _GradientIconState extends State<GradientIcon> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: widget.size * 1.2,
        height: widget.size * 1.2,
        child: Icon(
          widget.icon,
          size: widget.size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, widget.size, widget.size);
        return widget.gradient.createShader(rect);
      },
    );
  }
}

class MoviesListView extends StatelessWidget {
  final ScrollController scrollController;
  final List images;

  const MoviesListView(
      {Key? key, required this.scrollController, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/homescreen/${images[index]}',
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
