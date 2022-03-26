import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gamezy/utils/utils.dart';

class GlobalParam {
  static final GlobalParam globalParam = GlobalParam._internal();
  String udId = "";
  bool isInternetAvailable = false;

  factory GlobalParam() {
    return globalParam;
  }

  GlobalParam._internal() {
    initConnection();
  }

  initConnection() async {
    if (await (Connectivity().checkConnectivity()) != ConnectivityResult.none) {
      isInternetAvailable = true;
    } else {
      isInternetAvailable = false;
    }
    printIfDebug("global isInternetAvailable: $isInternetAvailable");
  }

  updateUdId(String id) {
    udId = id;
  }

  updateConnection(bool updateInternet) {
    isInternetAvailable = updateInternet;
  }
}
