

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woloo/config/app_color.dart';

import '../../../core/network/firebase_service.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  CloudFirestoreService? firestoreService;
  @override
  void initState() {
    super.initState();
    firestoreService = CloudFirestoreService(FirebaseFirestore.instance);
  }
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      backgroundColor: AppColors.grey,
      body: StreamBuilder(
          stream: firestoreService!.getTime(),
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
        //  final doc = snapshot.data?.docs.sort( );
                documents!.sort( ( a, b) => DateFormat('hh:mm:ss').parse(b["time"]).compareTo( DateFormat('hh:mm:ss').parse(a["time"] ) ) );
           print("documents ${documents }");
          return
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: ListView.builder(
                    itemCount: documents!.length,
                    itemBuilder: (context, index) {
                       return
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                              index == 0 ?
                       Text(documents[index]["date"],
                         style: const TextStyle(
                             color: AppColors.yellow
                         ),
                       ) : SizedBox(),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                                // padding: EdgeInsets.all(8),
                               color: AppColors.white,

                               child: ListTile(
                                  trailing: Text(documents[index]["time"]),

                                 title: Text(documents[index]["title"]),
                                                 ),
                             ),
                           ),
                         ],
                       );
                    },

                ),
              ),
            );

        }
      ),
    );
  }
}
