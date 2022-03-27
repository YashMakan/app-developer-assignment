import 'package:flutter/material.dart';
import 'package:gamezy/models/recommeded_tile.dart';
import 'package:gamezy/utils/utils.dart';

import '../models/user.dart';
import 'hardcode.dart';
import 'http_handler.dart';

class Api {
  static Future loginUser(
      {required String username,
      required String password,
        required String uId,
      required BuildContext context,
      bool useHardCodedResponse = false}) async {
    User? user;
    String url = "https://gamezy-backend.vercel.app/auth/login";
    if (useHardCodedResponse) {
      return User.fromJson(HardCodedResponse.loginResponse['data']);
    }
    await HttpHandler.postDataDio(
            url, {'username': username, 'password': password, 'uid': uId}, context)
        .then((response) {
      if (response['status'] == 200) {
        user = User.fromJson({'user_name': username, 'user_password': password, 'cuid': uId});
      }
    });
    return user;
  }

  static Future fetchRecommendedData(
      {required BuildContext context,
      required int limit,
      String? cursorPassed}) async {
    List<RecommendedTile> recommendedTileList = [];
    late String url;
    String? cursor = cursorPassed;
    if (cursor == null) {
      url =
          "https://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=$limit&status=all";
    } else {
      url =
          "https://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=$limit&status=all&cursor=$cursor";
    }

    await HttpHandler.getDataDio(url).then((response) {
      if (response['success']) {
        List tournaments = response['data']['tournaments'];
        cursor = response['data']['cursor'];
        for(var tournament in tournaments){
          recommendedTileList.add(RecommendedTile.fromJson(tournament));
        }
      } else {
        Utils.customFlushBar(
            context, ToastType.information, response['data']['error']);
      }
    });
    return [recommendedTileList, cursor];
  }
}
