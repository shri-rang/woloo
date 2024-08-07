import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:woloo/presentation/dashboard/view/status_screen.dart';
import 'package:woloo/utils/helpers/Image_provider.dart';

import '../../../config/app_color.dart';
import '../../../config/app_textstyle.dart';
import '../../../utils/resources/string_manager.dart';
import '../../../utils/resources/values_manager.dart';
import '../../../utils/ui/button.dart';
import '../../../utils/ui/horizontalPadding.dart';
import '../../../utils/ui/textfield.dart';
import '../../dashboard/view/dashboard.dart';
import '../controller/authController.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginCtrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _loginCtrl.loginformKey,
          child: PaddingWidget(
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 2.4,
                ),
                const CustomImageProvider(
                  image: "assets/images/woloo.png",
                  widht: 150,
                ),
                // const Header(
                //   title: AppStrings.welcomeBack,
                //   subTitle: AppStrings.beginJoureny,
                // ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                AppTextField(
                  controller: _loginCtrl.emailCtrl,
                  lableText: AppStrings.emailMobileNo,
                  inputfromatter: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]")),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
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

                    // return null;
                  },
                  hintText: AppStrings.enter,
                  borderColor: AppColors.lightyellow,
                  labelStyle: AppTextStyle.body1.copyWith(
                      fontWeight: FontWeight.w500, color: AppColors.white),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Obx(
                  () => AppTextField(
                    suffix: IconButton(
                        onPressed: () {
                          _loginCtrl.isObscure.value =
                              !_loginCtrl.isObscure.value;
                        },
                        icon: _loginCtrl.isObscure.value
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                size: 25,
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                size: 25,
                              )),
                    obscureText: _loginCtrl.isObscure.value,
                    controller: _loginCtrl.passwordCtrl,
                    lableText: AppStrings.password,
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
                    hintText: AppStrings.enterPassword,
                    borderColor: AppColors.lightyellow,
                    labelStyle: AppTextStyle.body1.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.white),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Obx(
                  () => _loginCtrl.isHigherNoSelected.value
                      ? Text(AppStrings.selectHigher,
                          style: AppTextStyle.body2Medium
                              .copyWith(color: AppColors.red))
                      : Container(),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Button(
                  colors: AppColors.lightyellow,
                  title: AppStrings.login,
                  onPressed: () {
                    if (_loginCtrl.loginformKey.currentState!.validate()) {
                      Get.off(const StatusScreen());
                    }
                  },
                ),
                   const SizedBox(
                  height: AppSize.s20,
                ),
                 InkWell(
                  onTap: () {
                   // Get.
                   Get.to(ForgotPassword());
                  },
                   child: const Text("Reset Password",
                    style: AppTextStyle.body1,
                   ),
                 ),
                const SizedBox(
                  height: AppSize.s10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
