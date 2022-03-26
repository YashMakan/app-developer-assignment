import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class GameListView extends StatelessWidget {
  final ScrollController scrollController;
  final List images;

  const GameListView(
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


Widget customTextField({required String text, required BuildContext context, required TextEditingController controller, required setState}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            border: Border.all(
                color: CustomColors().heading.color(context).withOpacity(0.7), width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TextField(
          textInputAction: TextInputAction.next,
          style: TextStyle(color: CustomColors().heading.color(context)),
          controller: controller,
          onChanged: (text) => setState(() {}),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: CustomColors().heading.color(context)),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: text,
            contentPadding:
            const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
        ),
      ),
      errorText(controller.text)!=null?Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(errorText(controller.text)!, style: const TextStyle(color: Colors.redAccent),),
      ):const SizedBox()
    ],
  );
}

String? errorText(text) {
  if (text.isEmpty) {
    return 'Invalid data passed';
  }
  if (text.length < 3) {
    return 'Too short';
  }
  if (text.length > 11) {
    return 'Too long';
  }
  return null;
}

Widget submitButton({required String text, required BuildContext context, required onTap, required bool isClickable}) {
  return GestureDetector(
    onTap: onTap,
    child: Opacity(
      opacity: isClickable?1:0.4,
      child: Container(
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
      ),
    ),
  );
}

Widget thirdPartyLoginButton({required String text, required IconData icon, required BuildContext context}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
        border: Border.all(
            color: CustomColors().heading.color(context).withOpacity(0.7), width: 1.5),
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