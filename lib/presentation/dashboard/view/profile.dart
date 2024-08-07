import 'package:flutter/material.dart';
import 'package:woloo/config/app_color.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool showPlayer = false;
  String? audioPath;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPlayer = false;
    // initializeDateFormatting();
    // firestoreService = CloudFirestoreService(FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.grey,
      body: Column(
        children: [
          //     :
        ],
      ),
    );
  }
}
