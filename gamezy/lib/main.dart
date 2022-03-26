import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:gamezy/api/http_handler.dart';
import 'package:gamezy/providers/root_provider.dart';
import 'package:gamezy/utils/global_param.dart';
import 'package:gamezy/utils/utils.dart';
import 'package:gamezy/views/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveBoxes.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RootProvider>(
        create: (_) => RootProvider(),
      )
    ],
    child: const Root(),
  ));
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  Future initConnectivity() async {
    GlobalParam().initConnection();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        GlobalParam().updateConnection(false);
      } else {
        printIfDebug('initConnectivity');
        GlobalParam().updateConnection(true);
      }
    });
  }

  Future updateUid() async {
    await FlutterUdid.udid.then((consistentId) {
      GlobalParam().updateUdId(consistentId);
    });
  }

  @override
  void initState() {
    updateUid();
    initConnectivity();
    HttpHandler().setInterceptor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamezy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
