import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigator {
  /// Custom adaptive route with smooth transitions.
  static Route<T> _adaptiveRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        if (Platform.isIOS) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          );
        }

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Future<T?> to<T>(Widget page) {
    return Navigator.push<T>(Get.context!, _adaptiveRoute(page));
  }

  static Future<T?> replace<T>(Widget page) {
    return Navigator.pushReplacement<T, T>(Get.context!, _adaptiveRoute(page));
  }

  static Future<T?> replaceAll<T>(Widget page) {
    return Navigator.pushAndRemoveUntil<T>(
      Get.context!,
      _adaptiveRoute(page),
      (route) => false,
    );
  }

  static void back<T>([T? result]) {
    Navigator.pop(Get.context!, result);
  }
}
