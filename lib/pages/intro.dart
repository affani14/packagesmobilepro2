import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import './login.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
    pages: [
      PageViewModel(
        title: "Title of first page",
        body: "Write the description here to explain everything",
        image: Center(
        child: SizedBox(
          width: 350,
          height: 350,
          child: Lottie.asset(
          "assets/lotties/laptop.json",
          fit: BoxFit.contain,
  ),
  ),
  ),
        ),
  PageViewModel(
  title: "Title of second page",
  body: "Write the description here to explain everything",
  image: Center(
  child: SizedBox(
  width: 250,
  height: 250,
  child: Lottie.asset(
  "assets/lotties/login.json",
  fit: BoxFit.contain,
        ),
    ),
  ),
  ),
    ],
  done: const Text("Login", style: TextStyle(fontWeight: FontWeight.w500)),
      showNextButton: true,
      next: Text("Next >>"),
      onDone: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),
      ),
      );
      },
    );
  }
}