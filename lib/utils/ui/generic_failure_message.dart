import 'package:flutter/material.dart';
import 'package:woloo/config/app_color.dart';

class GenericFailureMessage extends StatelessWidget {
  const GenericFailureMessage(
      {Key? key, required this.message, required this.onPress})
      : super(key: key);

  final String message;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: onPress,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.blue),
            ),
            child: const Text(
              "Retry",
              style: TextStyle(color: AppColors.blue),
            )),
        const SizedBox(
          height: 8,
        ),
        Text(
          message,
          style: const TextStyle(fontSize: 15, color: AppColors.blue),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
