import 'package:flutter/material.dart';
import 'package:woloo/config/app_color.dart';


class RadioButton extends StatefulWidget {
  final String? titleText;
  final List<String>? radioTitles;

  const RadioButton({super.key, this.titleText, this.radioTitles});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int? selectedVal;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
          spacing: 1.0, // gap between adjacent chips
          runSpacing: 2.0,
          children: [
            for (int i = 0; i < widget.radioTitles!.length; i++)
              select(widget.radioTitles![i], i)
          ]),
    );
  }

  Widget select(String title, int val) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Radio(
                fillColor: MaterialStateProperty.resolveWith((states) {
                  // active
                  if (states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                  // inactive
                  return Colors.grey.shade600;
                }),
                activeColor: AppColors.black.withOpacity(0.7),
                value: val,
                groupValue: selectedVal,
                onChanged: (v) {
                  selectedVal = v;
                  setState(() {});
                }),
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColors.black.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
