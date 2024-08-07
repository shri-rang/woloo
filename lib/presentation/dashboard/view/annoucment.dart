import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woloo/config/app_color.dart';
import 'package:woloo/config/app_textstyle.dart';
import '../../../core/network/firebase_service.dart';


class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  CloudFirestoreService? firestoreService;
  @override
  void initState() {
    super.initState();
    firestoreService = CloudFirestoreService(FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Column(
        children: [
          StreamBuilder(
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
                return DataTable(
                    columnSpacing: 20,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.lightyellow),
                    // border: TableBorder.all(width: 1.0, color: Colors.black),
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Login Time',
                            style: AppTextStyle.body2Medium
                                .copyWith(color: AppColors.black),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Cleaning Time',
                            style: AppTextStyle.body2Medium
                                .copyWith(color: AppColors.black),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Announcement Time ',
                            style: AppTextStyle.body2Medium
                                .copyWith(color: AppColors.black),
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      for (var date in documents!)
                        DataRow(cells: [
                          DataCell(
                            Text(
                              date["start_time"],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              date["exit_time"],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              date["announcement_time"],
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ])
                    ]);
              })
        ],
      ),
    );
  }
}
