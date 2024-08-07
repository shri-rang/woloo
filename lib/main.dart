import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woloo/config/app_color.dart';

import 'core/app/di.dart';
import 'core/app/firebase_options.dart';
import 'presentation/authentication/view/login.dart';
import 'presentation/dashboard/view/dashboard.dart';
import 'presentation/dashboard/view/details_screen.dart';
import 'presentation/navrail/navrail.dart';
import 'utils/resources/routes_manager.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      name: "woloo", options: DefaultFirebaseOptions.currentPlatform);
  // FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  await initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Woloo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: ThemeData(
        fontFamily: "Inter",
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.yellow),
        )),
        colorScheme: ColorScheme.fromSeed(
            primary: AppColors.yellow,
            secondary: AppColors.green,
            seedColor: Colors.transparent),
        useMaterial3: true,
      ),
      home:  DashBoard(),
    );
  }
}

// // Copyright 2017, Paul DeMarco.
// // All rights reserved. Use of this source code is governed by a
// // BSD-style license that can be found in the LICENSE file.

// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// // import 'package:flutter_blue_example/widgets.dart';

// import 'presentation/dashboard/view/find_devices.dart';
// import 'presentation/dashboard/widgets/bluetooth.dart';

// void main() {
//   runApp(FlutterBlueApp());
// }

// class FlutterBlueApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       color: Colors.lightBlue,
//       home:
//        StreamBuilder<BluetoothState>(
//           stream: FlutterBlue.instance.state,
//           initialData: BluetoothState.unknown,
//           builder: (c, snapshot) {
//             final state = snapshot.data;
//             if (state == BluetoothState.on) {
//               return FindDevicesScreen();
//             }
//             return BluetoothOffScreen(state: state);
//           }),
//     );
//   }
// }

// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

//   final BluetoothState? state;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Icon(
//               Icons.bluetooth_disabled,
//               size: 200.0,
//               color: Colors.white54,
//             ),
//             Text(
//               'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
//               // style: Theme.of(context)
//               //     .primaryTextTheme
//               //     .subhead
//               //     ?.copyWith(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


