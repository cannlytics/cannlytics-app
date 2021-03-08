import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cannlytics_app/_widgets/images/logo.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme?.scaffoldBackgroundColor,
      body: Center(
        child: Logo(),
      ),
    );
  }
}
