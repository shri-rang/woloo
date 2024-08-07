import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../config/app_color.dart';
import '../resources/values_manager.dart';

class OtpField extends StatelessWidget {
  final TextEditingController? pincontroller;
  const OtpField({super.key, this.pincontroller});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r6),
        border: Border.all(color: AppColors.borderColor),
      ),
    );
    return Directionality(
      // Specify direction if desired
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: pincontroller,
        // focusNode: focusNode,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        listenForMultipleSmsOnAndroid: true,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(width: 8),
        validator: (value) {
          return value == '2222' ? null : 'Pin is incorrect';
        },
        // onClipboardFound: (value) {
        //   debugPrint('onClipboardFound: $value');
        //   pinController.setText(value);
        // },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: (pin) {
          debugPrint('onCompleted: $pin');
        },
        onChanged: (value) {
          debugPrint('onChanged: $value');
        },
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: AppColors.focusedBorderColor,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(AppRadius.r6),
            border: Border.all(color: AppColors.focusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(AppRadius.r6),
            border: Border.all(color: AppColors.focusedBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }
}
