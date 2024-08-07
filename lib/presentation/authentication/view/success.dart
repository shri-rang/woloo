import 'package:flutter/material.dart';
import 'package:woloo/config/app_color.dart';
import 'package:woloo/presentation/authentication/widget/header.dart';
import 'package:woloo/utils/resources/string_manager.dart';
import 'package:woloo/utils/ui/horizontalPadding.dart';

import '../../../utils/resources/values_manager.dart';
import '../../../utils/ui/button.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: PaddingWidget(
        child: Column(
          children: [
            const CircleAvatar(
              radius: AppRadius.r70,
              backgroundColor: Color(0xfff3f9f4),
              child: Icon(
                Icons.check_circle_outline,
                size: AppSize.s100,
                color: AppColors.green,
              ),
            ),
            const Header(
              title: AppStrings.successMessageHeader,
              subTitle: AppStrings.passwordResetSuccessMessage,
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Button(
              onPressed: () {},
              title: AppStrings.continuee,
            )
          ],
        ),
      ),
    );
  }
}
