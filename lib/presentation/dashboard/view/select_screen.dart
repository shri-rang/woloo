import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woloo/config/app_color.dart';

import '../../../core/network/firebase_service.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  CloudFirestoreService? firestoreService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestoreService = CloudFirestoreService(FirebaseFirestore.instance);
  }

  List<String> dropdown = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: StreamBuilder(
          stream: firestoreService!.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error fetching data: ${snapshot.data}');
            } else if (snapshot.hasData &&
                snapshot.data!.docs.isEmpty == true) {
              return const Center(child: Text('Empty documents'));
            }
            final documents = snapshot.data?.docs;
            for (var element in documents!) {
              dropdown.add(element["title"]);
            }

            dropdown = dropdown.toSet().toList();
            // documents!.map((p) => dropdown.add(p["title"]));
            print("dsfsdf $documents");
            print("dropdrow $dropdown");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //     ExpansionTile(title: title),
                Center(
                  child: DropdownButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.yellow,
                      size: 30,
                    ),
                    hint: const Text(
                      "Select washroom",
                      style: TextStyle(color: AppColors.white),
                    ),
                    items: dropdown.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                )
              ],
            );
          }),
    );
  }
}
