import 'dart:async';

import 'package:donor_app/Modules/Auth/UI/login.dart';
import 'package:donor_app/Shared/UI/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login())));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash.jpg'), // Background image path
            fit: BoxFit.cover, // Fit the image to cover the entire screen
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          color: const Color(0xFF0B385B).withOpacity(0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset(
                  'assets/logo_white.png',
                  height: 150,
                  width: 150,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Donor Relationship Application",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 36),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.blueColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    'Get Started!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      "Follow us",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/facebook.png",
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/linkin.png",
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/twitter.png",
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/insta.png",
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/youtube.png",
                          width: 36,
                          height: 36,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text(
                      "www.nust.edu.pk",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text(
                      "National University of Sciences & \n Technology (NUST)",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
