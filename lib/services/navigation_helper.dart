import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  //* PUSH a new screen (keep history)
  void goToScreen(BuildContext context, String routeName, {Object? extra}) {
    if (kDebugMode) {
      print('GO TO SCREEN >> $routeName');
    }
    context.push(routeName, extra: extra);
  }

  //* GO + clear all history (remove everything from back stack)

  void goToScreenAndClearAll(
    BuildContext context,
    String routeName, {
    Object? extra,
  }) {
    if (kDebugMode) {
      print('GO TO SCREEN CLEAR ALL >> $routeName');
    }
    context.go(routeName, extra: extra);
  }

  //* Replace last screen

  void goToScreenReplace(
    BuildContext context,
    String routeName, {
    Object? extra,
  }) {
    if (kDebugMode) {
      print('GO TO SCREEN REPLACE >> $routeName');
    }
    context.pushReplacement(routeName, extra: extra);
  }

  //* GO TO SCREEN and receive value when popping back

  void goToScreenWithGoBack(
    BuildContext context,
    String routeName,
    Function(dynamic value) onReturn, {
    Object? extra,
  }) async {
    if (kDebugMode) {
      print('GO TO SCREEN WITH CALLBACK >> $routeName');
    }
    context.push(routeName, extra: extra).then(onReturn);
  }

  //* Close current dialog/page
  void closeDialog(BuildContext context, [dynamic result]) {
    context.pop(result);
  }
}