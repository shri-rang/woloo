import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:woloo/utils/ui/button.dart';
import 'package:woloo/utils/ui/horizontalPadding.dart';

import '../../../config/app_color.dart';
import '../../../config/app_textstyle.dart';
import '../../../utils/resources/string_manager.dart';
import '../../../utils/resources/values_manager.dart';
import '../../../utils/ui/textfield.dart';
import '../controller/authController.dart';
import '../widget/header.dart';
import 'verification.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _authCtrl = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
            backgroundColor: AppColors.grey,
          leading: IconButton(onPressed: () {
             Get.back();
          }   , icon:  const Icon( Icons.arrow_back,
           color: AppColors.white,
           ) ),
          ),
      body: PaddingWidget(
        child: Form(
          key: _authCtrl.forgotPassFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: AppSize.s24,
              ),
              const Header(
                title: AppStrings.forgotPass,
                subTitle: AppStrings.verificationCodeonAddress,
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              AppTextField(
                textInputType: TextInputType.datetime,
                controller: _authCtrl.forgotPassEmailCtrl,
                lableText: AppStrings.emailMobileNo,
                inputfromatter: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]")),
                ],
                validator: (value) {
                  if (value!.isNum) {
                    if (value.length != 10) {
                      return AppStrings.mobileNoMustBe;
                    } else {
                      return null;
                    }
                  } else if (value.isEmpty) {
                    return AppStrings.enterMobileNo;
                  } else {
                    //  if(value){
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return AppStrings.enterValidEmail;
                    } else {
                      return null;
                    }
                  }
                },
                hintText: AppStrings.enter,
                borderColor: AppColors.loginFieldStorke,
                labelStyle: AppTextStyle.body1.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.loginLabelText),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Button(
                colors: AppColors.lightyellow,
                onPressed: () {
                 if (_authCtrl.forgotPassFormKey.currentState!.validate()) {
                    Get.to(const VerificationScreen());
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
