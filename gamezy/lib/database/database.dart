import 'package:gamezy/models/user.dart';
import 'package:hive/hive.dart';

class HiveBoxes{
  static const userDetails = "user_details";


  static initialize() async {
    await Hive.openBox(userDetails);
  }

  static clearAllBox() async {
    await HiveBoxes.userDetailsBox().clear();
  }


  static Box userDetailsBox() => Hive.box(userDetails);
}

class HiveHelper{
  static bool isUserLoggedIn() => HiveBoxes.userDetailsBox().isNotEmpty;

  static User getUserDetails() =>
      HiveBoxes.userDetailsBox().toMap().isNotEmpty
          ? User.fromJson(HiveBoxes.userDetailsBox().toMap())
          : User();

  static Future updateUserDetails(User? user) async {
    if (user != null) {
      await HiveBoxes.userDetailsBox().putAll(user.toJson());
    } else {
      await HiveBoxes.clearAllBox();
    }
    return HiveBoxes.userDetailsBox().toMap();
  }
}