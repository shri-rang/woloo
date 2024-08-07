import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woloo/config/app_color.dart';
import 'package:woloo/config/app_textstyle.dart';
import 'package:woloo/utils/resources/values_manager.dart';

class AppTextField extends StatelessWidget {
  final String? lableText;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final void Function(String?)? onChange;
  final void Function(String?)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputfromatter;
  final TextCapitalization? textCapital;
  final InputDecoration? deco;
  final Color borderColor;
  final int? length;
  final String? hintText;
  final FocusNode? focus;
  final bool? obscureText;
  const AppTextField(
      {super.key,
      required this.lableText,
      this.labelStyle,
      required this.controller,
      this.deco,
      this.inputfromatter,
      this.length,
      this.onChange,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.suffix,
      this.textCapital,
      this.borderColor = AppColors.stroke,
      this.textInputType,
      this.validator,
      this.focus,
      this.obscureText = false,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lableText!, style: labelStyle
            //  AppTextStyle.body1.copyWith(
            //     fontWeight: FontWeight.w500, color: AppColors.outerInputText),
            ),
        const SizedBox(
          height: AppSize.s8,
        ),
        TextFormField(
          focusNode: focus,
          controller: controller,
          obscureText: obscureText!,
          // maxLength: 10,
          keyboardType: textInputType,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          cursorColor: Colors.black,
          cursorWidth: 1,
          onChanged: onChange,
          textInputAction: TextInputAction.done,
          // maxLength: length ?? 20,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputfromatter,
          style: TextStyle(color: Colors.white),
          textCapitalization: textCapital ?? TextCapitalization.sentences,
          decoration: deco ??
              InputDecoration(
                counterText: "",
                suffixIcon: suffix,
                hintText: hintText,
                isDense: true, // Added this
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
                hintStyle: AppTextStyle.body1.copyWith(
                    fontWeight: FontWeight.w100,
                    color: AppColors.innerInputText),
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 2, minHeight: 10),
                prefixStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: borderColor, width: 1.5),
                ),

                // labelText: lableText,
                // labelStyle: Theme.of(context).textTheme.headline4!,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: borderColor, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: AppColors.red, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: borderColor, width: 1.5),
                ),
              ),
        )
      ],
    );
  }
}
