import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:woloo/config/app_textstyle.dart';
import 'package:woloo/presentation/authentication/view/reset_password.dart';
import 'package:woloo/utils/resources/string_manager.dart';
import 'package:woloo/utils/resources/values_manager.dart';
import 'package:woloo/utils/ui/horizontalPadding.dart';
import 'package:woloo/utils/ui/otpfield.dart';

import '../../../config/app_color.dart';
import '../../../utils/ui/button.dart';
import '../controller/authController.dart';
import '../widget/header.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  final _authCtrl = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    _authCtrl.startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PaddingWidget(
          child: Column(
        children: [
          const Header(
            title: AppStrings.verification,
            subTitle: AppStrings.verificationCodeSent,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Obx(
            () => Text(_authCtrl.timerText.value, style: AppTextStyle.heading2),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          OtpField(
            pincontroller: _authCtrl.pinController,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Center(
              child: RichText(
            text: TextSpan(
              style: AppTextStyle.body2Medium
                  .copyWith(color: AppColors.outerInputText),
              children: <TextSpan>[
                const TextSpan(
                  text: AppStrings.couldNotGetCode,
                  // style: TextStyle(color: Colors.orange)
                ),
                TextSpan(
                  text: AppStrings.resend,
                  style: const TextStyle(
                      color: AppColors.blue,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Single tapped.
                      // _authCtrl.stopTimer();
                      _authCtrl.startTimeout();
                    },
                )
              ],
            ),
            textAlign: TextAlign.center,
          )),
          const SizedBox(
            height: AppSize.s20,
          ),
          Button(
            onPressed: () {
              Get.to(const ResetPassword());
            },
            title: AppStrings.verify,
          )
        ],
      )),
    );
  }
}
