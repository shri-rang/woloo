import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:woloo/config/app_color.dart';
import 'package:woloo/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:woloo/presentation/dashboard/view/annoucment.dart';
import 'package:woloo/presentation/dashboard/view/profile.dart';
import 'package:woloo/presentation/dashboard/view/status_screen.dart';
import 'package:woloo/utils/helpers/Image_provider.dart';
import '../../../config/app_textstyle.dart';
import '../../../utils/resources/string_manager.dart';
import 'time_table.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final dashCtrl = Get.put(DashboardController());

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    StatusScreen(),
    TimeTable(),
    MyWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  // late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    // _adapterStateStateSubscription =
    //     FlutterBluePlus.adapterState.listen((state) {
    //   _adapterState = state;
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
    //hey();
  }

  @override
  void dispose() {
    // _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   //  print(dashCtrl.adapterState.value);
      // }),
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        // elevation: 1,

        title: const Text(
          AppStrings.appName,
          style: AppTextStyle.heading2,
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () async {}, icon: const Icon(Icons.notifications)),
        //   CircleAvatar(
        //       child:
        //           IconButton(onPressed: () {}, icon: const Icon(Icons.person))),
        //   const SizedBox(
        //     width: 10,
        //   ),
        // ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.lightyellow,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: CustomImageProvider(
                image: "assets/images/status.png",
                height: 30,
                widht: 30,
              ),
              label: 'Status',
              backgroundColor: AppColors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined),
              label: 'Time Track',
              backgroundColor: AppColors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              // backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: AppColors.white,
          iconSize: 35,
          onTap: _onItemTapped,
          elevation: 5),
    );
    //  Scaffold(
    //   drawer: const Drawer(),
    //   appBar: AppBar(
    //     // elevation: 1,

    //     title: const Text(
    //       AppStrings.appName,
    //       style: AppTextStyle.heading2,
    //     ),
    //     actions: [
    //       IconButton(
    //           onPressed: () async {}, icon: const Icon(Icons.notifications)),
    //       CircleAvatar(
    //           child:
    //               IconButton(onPressed: () {}, icon: const Icon(Icons.person))),
    //       const SizedBox(
    //         width: 10,
    //       ),
    //     ],
    //   ),
    //   body: PaddingWidget(
    //     child: Column(
    //       children: [
    //         const Divider(),
    //         GridView.builder(
    //           shrinkWrap: true,
    //           itemCount: washroomList.length,
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //               childAspectRatio: 0.85,
    //               mainAxisSpacing: 10,
    //               crossAxisSpacing: 10,
    //               crossAxisCount: 2),
    //           itemBuilder: (context, index) {
    //             return Card(
    //               child: Padding(
    //                 padding: const EdgeInsets.all(12.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       washroomList[index].title!,
    //                       style: AppTextStyle.heading2,
    //                     ),
    //                     const SizedBox(
    //                       height: AppSize.s10,
    //                     ),
    //                     CustomImageProvider(
    //                       image: washroomList[index].img,
    //                     ),
    //                     const SizedBox(
    //                       height: AppSize.s10,
    //                     ),
    //                     Row(
    //                       children: [
    //                         const Text(
    //                           "Status",
    //                           style: AppTextStyle.body1,
    //                         ),
    //                         Spacer(),
    //                         CircleAvatar(
    //                           radius: 7,
    //                           foregroundColor: washroomList[index].statusColor,
    //                           backgroundColor: washroomList[index].statusColor,
    //                         ),
    //                         const SizedBox(
    //                           width: AppSize.s4,
    //                         ),
    //                         Text(
    //                           washroomList[index].status!,
    //                           style: AppTextStyle.body2Medium,
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             );
    //           },
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
