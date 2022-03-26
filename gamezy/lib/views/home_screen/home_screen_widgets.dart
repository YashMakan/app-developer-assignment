import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamezy/models/recommeded_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';

Widget recommendedItem(BuildContext context, RecommendedTile recommendedTile) {
  double widgetHeight = MediaQuery.of(context).size.height * 0.18;
  return Padding(
    padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
    child: GestureDetector(
      onTap: ()async{
        if (!await launch(recommendedTile.url)) throw 'Could not launch ${recommendedTile.url}';
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widgetHeight,
        decoration: BoxDecoration(
            color: context.isDarkMode()
                ? Colors.black
                : CustomColors().background.color(context),
            boxShadow: [
              BoxShadow(
                  color: context.isDarkMode()
                      ? Colors.grey.shade600
                      : Colors.grey.shade400,
                  blurRadius: 4,
                  spreadRadius: 0.3),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: widgetHeight / 2,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(recommendedTile.imageUrl),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          recommendedTile.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: CustomColors().heading.color(context)),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        recommendedTile.subtitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: context.isDarkMode()
                                ? Colors.white38
                                : Colors.black38),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.chevron_right, size: 18),
                    onPressed: () async {
                      if (!await launch(recommendedTile.url)) throw 'Could not launch ${recommendedTile.url}';
                    },
                    color: context.isDarkMode()
                        ? Colors.white24
                        : Colors.black12,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget customContainer(context,
    {bool left = false,
    bool center = false,
    bool right = false,
    required List<Color> colors,
    required String heading,
    required String subheading}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.3,
    height: 80,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            stops: const [0.2, 0.5, 1],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
        borderRadius: left
            ? const BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
            : right
                ? const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))
                : null),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heading,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            subheading.splitMapJoin(" ", onMatch: (_) => "\n"),
            style: const TextStyle(color: Colors.white, fontSize: 13),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}
