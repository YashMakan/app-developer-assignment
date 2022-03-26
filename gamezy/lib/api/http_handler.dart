import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gamezy/database/database.dart';

import '../utils/global_param.dart';
import '../utils/utils.dart';

var dio = Dio();

class HttpHandler {
  void setInterceptor() {
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      options.headers = {
        'udid': GlobalParam().udId,
        'devicetype': Platform.isAndroid ? 'A' : 'I',
        if (HiveHelper.getUserDetails().cuId!.isNotEmpty)
          'cuid': HiveHelper.getUserDetails().cuId!
      };
      printIfDebug('options.headers: ${options.headers}');
      return handler.next(options);
    }, onResponse: (response, handler) {
//todo token reset;
      return handler.next(response);
    }, onError: (DioError e, handler) {
      return handler.next(e);
    }));
  }

  static Future<Map> postDataDio(
      String url, Map<String, dynamic> postData, context) async {
    printIfDebug("URL: $url");
    printIfDebug("data: $postData");
    if (GlobalParam().isInternetAvailable) {
      var res = await dio
          .post(
        url,
        data: FormData.fromMap(postData),
        options: Options(
          responseType: ResponseType.plain,
        ),
      )
          .catchError((error) {
        printIfDebug('Error $error');
        if (error.toString().contains('Http status error [500]')) {
          return Response(
              data: jsonEncode({
                'status': false,
                'message': 'Contact admin, something went wrong'
              }),
              statusCode: 500,
              requestOptions: RequestOptions(path: ''));
        } else {
          return Response(
              data: jsonEncode(
                  {'status': false, 'message': 'something went wrong'}),
              requestOptions: RequestOptions(path: ''));
        }
      });
      printIfDebug("Response: ${res.data}");
      Map data = json.decode(res.data);
      return data;
    } else {
      Utils.customFlushBar(
          context, ToastType.information, "Connect to you internet connection.");
      return {
        'status': false,
        'message': 'Please connect to internet',
        'data': {}
      };
    }
  }

  static Future<Map> getDataDio(String url, {Map<String, String?>? headers}) async {
    var res = await Dio()
        .get(
      url,
      options: Options(
        headers: headers,
        responseType: ResponseType.plain,
      ),
    )
        .timeout(const Duration(seconds: 40),
        onTimeout: () => Response(
            data: jsonEncode(
                {'status': false, 'message': 'Time out exception'}),
            statusCode: 200,
            requestOptions: RequestOptions(path: '')));

    printIfDebug(res.statusCode);
    Map? data = json.decode(res.data);
    return data??{};
  }
}
