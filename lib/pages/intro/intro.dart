import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';

import '../language/languages.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Introduction Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(focusColor:Color(0xfff3c92e) ,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xfff3c92e)),
        useMaterial3: true,
      ),
      home: const Intro(),
    );
  }

  @override
  State<Intro> createState() => _IntroState();
}

/// List of pages to be shown in the introduction
///
final List<SingleIntroScreen> pages = [
  const SingleIntroScreen(
    mainCircleBgColor: Color(0xFFFFFFFF),
    sideDotsBgColor: Color(0xFFFFFFFF),
    title: 'Welcome to NextDrive!',
    description: 'You plan your trip, We\'ll do the rest and will be the best! Guaranteed!  ',
    imageAsset: 'assets/images/intro_5.png',

  ),
  const SingleIntroScreen(
    mainCircleBgColor: Color(0xFFFFFFFF),
    sideDotsBgColor: Color(0xFFFFFFFF),
    title: 'Book a ride for now or for later',
    description: 'Book a ride with NextDrive for now or for future with advance booking features. you will love the way of booking with NextDrive !',
    imageAsset: 'assets/images/intro_4.png',
  ),
  const SingleIntroScreen(
    mainCircleBgColor: Color(0xFFFFFFFF),
    sideDotsBgColor: Color(0xFFFFFFFF),
    title: 'Grabs all rides now only in your hands',
    description: 'All rides are now in your hands, just a click away, so what are you waiting for plan your ride today and make it memorable with NextDrive! ',
    imageAsset: 'assets/images/intro_3.png',
  ),
];

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return AnimatedIntroduction(
      slides: pages,
      indicatorType: IndicatorType.circle,

      activeDotColor: Colors.black,

      inactiveDotColor: Colors.white,
      footerBgColor: const Color(0xfff3c92e),
      textColor: Colors.black,
      containerBg: Colors.white,

      skipText: "Skip",
      nextText: "Next",
      doneText: "Login Page",
      onDone: () {
        /// TODO: Go to desire page like login or home
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Languages()));
      },
    );
  }
}