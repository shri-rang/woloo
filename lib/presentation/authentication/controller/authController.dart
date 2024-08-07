import 'dart:async'; // Import for using Timer
import 'dart:math'; // Import for generating random numbers

import 'package:flutter/material.dart'; // Flutter Material package
import 'package:get/get.dart'; // GetX package for state management

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Initialize the controller
    // Generate random numbers for captcha
    genrateRandomNo();
  }

  // Form Keys
  final loginformKey = GlobalKey<FormState>();
  final forgotPassFormKey = GlobalKey<FormState>();
  final resetPassFormKey = GlobalKey<FormState>();

  // Text Field Controllers for Login
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController loginCtrl = TextEditingController();

  // Text Field Controllers for Forgot Password
  TextEditingController forgotPassEmailCtrl = TextEditingController();

  // Text Field Controllers for Reset Password
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  final pinController = TextEditingController();

  // Variables for Captcha
  var rng = Random(); // Random number generator
  RxList<String> captchaList =
      <String>[].obs; // Observable list for captcha values
  RxInt selectedIndex =
      0.obs; // Observable index for the selected captcha value

  // Variables for Login
  RxBool isObscure =
      true.obs; // Observable boolean to toggle password visibility
  RxBool isHigherNoSelected = false.obs;

  // Variables for Timer
  RxBool enableResend = false.obs;
  final interval = const Duration(seconds: 1); // Timer interval
  final int timerMaxSeconds = 60; // Maximum timer seconds
  RxInt currentSeconds = 0.obs; // Current timer seconds
  RxString get timerText =>
      '${((timerMaxSeconds - currentSeconds.value) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds.value) % 60).toString().padLeft(2, '0')}'
          .obs; // Computed property for displaying timer text
  Timer? countdownTimer; // Timer object for countdown

  // Method to generate random numbers for Captcha
  genrateRandomNo() {
    captchaList.clear(); // Clear existing captcha list
    for (var i = 0; i < 3; i++) {
      // Generate 3 random numbers for captcha
      String randomNo = rng
          .nextInt(999)
          .toString(); // Generate random number between 0 and 999

      // Padding random number with leading zeros if necessary
      if (randomNo.toString().length == 2) {
        var newrand = "0$randomNo";
        randomNo = newrand;
      } else if (randomNo.toString().length == 1) {
        var newrand = "00$randomNo";
        randomNo = newrand;
      }

      captchaList.add(
          randomNo.toString()); // Add generated random number to captcha list
    }
  }

  // Method to start timeout for resend functionality
  startTimeout([int? milliseconds]) {
    var duration = interval;
    enableResend.value = false;

    countdownTimer = Timer.periodic(duration, (timer) {
      currentSeconds.value = timer.tick;
      update();
      if (timer.tick >= timerMaxSeconds) timer.cancel();
      if (timer.tick == 0) {
        enableResend.value = true;
      }
    });
  }

  // Method to stop the countdown timer
  stopTimer() {
    countdownTimer?.cancel();
    update();
  }
}
