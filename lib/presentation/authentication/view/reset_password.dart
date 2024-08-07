import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woloo/presentation/authentication/view/success.dart';
import 'package:woloo/presentation/authentication/widget/header.dart';
import 'package:woloo/utils/resources/string_manager.dart';
import 'package:woloo/utils/ui/horizontalPadding.dart';
import 'package:woloo/utils/ui/textfield.dart';

import '../../../utils/resources/values_manager.dart';
import '../../../utils/ui/button.dart';
import '../controller/authController.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _authCtrl = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PaddingWidget(
        child: Form(
          key: _authCtrl.resetPassFormKey,
          child: Column(
            children: [
              const Header(
                title: AppStrings.resetPassword,
                subTitle: AppStrings.setNewPassword,
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              AppTextField(
                lableText: AppStrings.newPassword,
                controller: _authCtrl.newPasswordCtrl,
                hintText: AppStrings.enterPassword,
                validator: (value) {
                  var passNonNullValue = value ?? "";
                  if (passNonNullValue.isEmpty) {
                    return (AppStrings.passwordIsRequired);
                  } else if (passNonNullValue.length < 8) {
                    return (AppStrings.passwordMustBe);
                  } else if (!AppStrings.passwordRegex
                      .hasMatch(passNonNullValue)) {
                    return (AppStrings.passwordShouldContain);
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              AppTextField(
                lableText: AppStrings.confirmPassword,
                controller: _authCtrl.confirmPasswordCtrl,
                hintText: AppStrings.enterPassword,
                validator: (value) {
                  var passNonNullValue = value ?? "";
                  if (passNonNullValue.isEmpty) {
                    return (AppStrings.passwordIsRequired);
                  } else if (passNonNullValue.length < 8) {
                    return (AppStrings.passwordMustBe);
                  } else if (!AppStrings.passwordRegex
                      .hasMatch(passNonNullValue)) {
                    return (AppStrings.passwordShouldContain);
                  } else if (value != _authCtrl.newPasswordCtrl.text) {
                    return (AppStrings.passwordShouldSame);
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Button(
                onPressed: () {
                  if (_authCtrl.resetPassFormKey.currentState!.validate()) {
                    Get.to(const Success());
                  }
                },
                title: AppStrings.continuee,
              )
            ],
          ),
        ),
      ),
    );
  }
}
