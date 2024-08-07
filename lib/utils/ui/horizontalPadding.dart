import 'package:flutter/material.dart';
import 'package:woloo/utils/resources/values_manager.dart';

class PaddingWidget extends StatelessWidget {
  final Widget child;
  const PaddingWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: child,
    );
  }
}
