import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { warning, success, error, information }

class Utils{
  static customFlushBar(
      BuildContext context, ToastType toastType, String message) async {
    FToast fToast = FToast();
    fToast.init(context);
    getStripColor() {
      switch (toastType) {
        case ToastType.warning:
          return Colors.yellow[800];
        case ToastType.success:
          return Colors.green;
        case ToastType.error:
          return Colors.red;
        case ToastType.information:
          return Colors.blueAccent;
      }
    }

    getBackGroundColor() {
      switch (toastType) {
        case ToastType.warning:
          return Colors.amber[100];
        case ToastType.success:
          return Colors.green[50];
        case ToastType.error:
          return Colors.red[50];
        case ToastType.information:
          return Colors.blue[50];
      }
    }

    getToastTypeLabel() {
      switch (toastType) {
        case ToastType.warning:
          return 'Warning';
        case ToastType.success:
          return 'Success';
        case ToastType.error:
          return 'Error';
        case ToastType.information:
          return 'Info';
      }
    }

    getIcon() {
      switch (toastType) {
        case ToastType.warning:
          return Icons.warning_amber_outlined;

        case ToastType.success:
          return Icons.check_circle;

        case ToastType.error:
          return Icons.error;
        case ToastType.information:
          return Icons.info;
      }
    }

    await Flushbar(
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.only(bottom: 100.0, left: 10.0, right: 10.0),
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.BOTTOM,
      forwardAnimationCurve: Curves.ease,
      animationDuration: const Duration(milliseconds: 300),
      reverseAnimationCurve: Curves.easeInBack,
      positionOffset: 20.0,
      borderRadius: BorderRadius.circular(5.0),
      backgroundColor: getBackGroundColor()!,
      leftBarIndicatorColor: getStripColor(),
      icon: Icon(
        getIcon(),
        color: getStripColor(),
        size: 18,
      ),
      titleText: Text(
        getToastTypeLabel(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      titleColor: Colors.black,
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    ).show(context);
  }
}

printIfDebug(data) {
  if (kDebugMode) {
    print(data);
  }
}