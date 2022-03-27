import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:gamezy/api/api.dart';
import 'package:gamezy/database/database.dart';
import 'package:gamezy/providers/root_provider.dart';
import 'package:gamezy/views/splash_screen.dart';
import 'package:gamezy/widgets/common_widgets.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../constants/colors.dart';
import 'home_screen_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  int limit = 10;

  @override
  void initState() {
    getData(init: true);
    super.initState();
  }

  getData({bool init = false}) async {
    Future.delayed(Duration.zero, ()async{
      if(init){
        Provider.of<RootProvider>(context, listen: false).clearTiles();
        Provider.of<RootProvider>(context, listen: false).updateCursor(null);
      }
      var response = await Api.fetchRecommendedData(
          context: context, limit: limit, cursorPassed: Provider.of<RootProvider>(context, listen: false).cursor);
      Provider.of<RootProvider>(context, listen: false).addTiles(response[0]);
      Provider.of<RootProvider>(context, listen: false).updateCursor(response[1]);
      isLoading = false;
      if(init){
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: CustomColors().background.color(context),
        body: isLoading
            ? GWidgets.loader()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Feather.menu),
                              onPressed: () {},
                              color: CustomColors().heading.color(context),
                            ),
                            Text(
                              "Flyingwolf",
                              style: TextStyle(
                                  color: CustomColors().heading.color(context),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            IconButton(
                              icon: const Icon(Feather.log_out),
                              onPressed: () {
                                HiveBoxes.clearAllBox();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SplashScreen()),
                                );
                              },
                              color: CustomColors().heading.color(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.11,
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://media.istockphoto.com/photos/professional-gamer-playing-picture-id1206214944?b=1&k=20&m=1206214944&s=170667a&w=0&h=BkKsPNFtnX85mdG2C3WV6mLwJ__7vJyZYye1PajEmoM="),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(HiveHelper.getUserDetails().userName!,
                                      style: TextStyle(
                                          color: CustomColors()
                                              .heading
                                              .color(context),
                                          fontSize: 21,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 145,
                                    height: 38,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        border: Border.all(color: Colors.blue)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text("2250",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text("Elo rating",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customContainer(context,
                                left: true,
                                colors: [
                                  Colors.orangeAccent,
                                  Colors.orange,
                                  Colors.deepOrangeAccent
                                ],
                                subheading: "Tournaments played",
                                heading: "34"),
                            customContainer(context,
                                center: true,
                                colors: [
                                  Colors.pinkAccent,
                                  Colors.pink,
                                  Colors.redAccent
                                ],
                                subheading: "Tournaments won",
                                heading: "09"),
                            customContainer(context,
                                right: true,
                                colors: [
                                  Colors.redAccent,
                                  Colors.red,
                                  Colors.deepOrange
                                ],
                                subheading: "winning percentage",
                                heading: "26%")
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Recommended for you",
                            style: TextStyle(
                                color: CustomColors().heading.color(context),
                                fontSize: 23,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<RootProvider>(
                        builder: (context, data, child) {
                          return ListView.builder(
                            itemCount: data.recommendedTileList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                recommendedItem(context,
                                    data.recommendedTileList.elementAt(index)),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: VisibilityDetector(
                          onVisibilityChanged: (visibilityInfo) {
                            var visiblePercentage =
                                visibilityInfo.visibleFraction * 100;
                            if (visiblePercentage > 50) {
                              getData();
                            }
                          },
                          key: const Key('listview_end'),
                          child: const Center(child: CircularProgressIndicator(color: Colors.pinkAccent,)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
