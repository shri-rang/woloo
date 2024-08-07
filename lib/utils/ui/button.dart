import 'package:flutter/material.dart';
import 'package:woloo/config/app_textstyle.dart';

import '../../config/app_color.dart';

class Button extends StatefulWidget {
  final Function()? onPressed;
  final String? title;
  final Color? colors;
  const Button({super.key, this.title, this.onPressed, this.colors});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.colors!,
          fixedSize: const Size(double.maxFinite, 50),
          // foregroundColor: Colors.blueAccent,ss
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          //backgroundColor: Colors.black
        ),
        // backgroundColor: AppColors.blue),
        child: Text(
          widget.title!,
          style: AppTextStyle.heading2
              .copyWith(fontWeight: FontWeight.w500, color: AppColors.black),
        ));
  }
}
