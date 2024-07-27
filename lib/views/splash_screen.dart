import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurants_locations/views/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Get.offNamed('/map');
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/splash.png",
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "WELCOME TO FOOD TOUR",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              // Text(
              //   "IN",
              //   style: TextStyle(
              //       color: Colors.red,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              Text(
                "ISLAMABAD",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
