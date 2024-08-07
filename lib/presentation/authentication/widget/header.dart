import 'package:flutter/material.dart';
import '../../../config/app_color.dart';
import '../../../config/app_textstyle.dart';
import '../../../utils/resources/values_manager.dart';

class Header extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const Header({super.key, this.subTitle, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Center(
          child: Text(
            title!,
            style: AppTextStyle.heading1,
          ),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
            child: Text(
              textAlign: TextAlign.center,
              subTitle!,
              style: AppTextStyle.heading2
                  .copyWith(color: AppColors.outerInputText),
            ),
          ),
        ),
      ],
    );
  }
}
