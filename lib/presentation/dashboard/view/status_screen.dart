import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:woloo/config/app_color.dart';
import 'package:woloo/presentation/dashboard/view/details_screen.dart';
import 'package:woloo/presentation/dashboard/view/find_devices.dart';
import 'package:woloo/utils/ui/button.dart';

import '../../../config/app_textstyle.dart';
import '../../../core/network/firebase_service.dart';
import '../../../utils/helpers/Image_provider.dart';
import '../../../utils/resources/string_manager.dart';
import '../../../utils/resources/values_manager.dart';
import '../../../utils/ui/horizontalPadding.dart';
import '../../../utils/ui/textfield.dart';
import '../../authentication/controller/authController.dart';
import '../controller/dashboard_controller.dart';
// import '../widgets/audio_player.dart';
// import '../widgets/audio_player.dart';

import 'package:audioplayers/audioplayers.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final dashCtrl = Get.put(DashboardController());
  bool showPlayer = false;
  String? audioPath;
  late AudioPlayer player = AudioPlayer();
  final _loginCtrl = Get.put(AuthController());

  final fromKey = GlobalKey<FormState>();

  Future playSampleSound() async {
    await player.setSource(AssetSource('sample.mp3'));
    await player.resume();
  }

  void stopSound() async {
    await player.stop();
  }
  // final appPre = AppPreferences(sharedPreferences);
  // instance.registerLazySingleton<AppPreferences>(
  //     () => AppPreferences(instance()));

  var network;
  CloudFirestoreService? firestoreService;
  var format = DateFormat('hh:mm:ss');

  showDailog(String id, bool isOccupied) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // title: const Text("Login"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,
          // actions: [
          //   ElevatedButton(onPressed: () {}, child: const Text("Back")),
          //   ElevatedButton(onPressed: () {}, child: const Text("Next")),
          // ],
          content: StreamBuilder(
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
                return SizedBox(
                  height: 200,
                  width: 400,
                  child: Form(
                    key: fromKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => AppTextField(
                            suffix: IconButton(
                                onPressed: () {
                                  _loginCtrl.isObscure.value =
                                      !_loginCtrl.isObscure.value;
                                },
                                icon: _loginCtrl.isObscure.value
                                    ? const Icon(
                                        Icons.visibility_off_outlined,
                                        size: 25,
                                      )
                                    : const Icon(
                                        Icons.visibility_outlined,
                                        size: 25,
                                      )),
                            obscureText: _loginCtrl.isObscure.value,
                            controller: _loginCtrl.loginCtrl,
                            lableText: AppStrings.password,
                            validator: (value) {
                              var passNonNullValue = value ?? "";
                              if (passNonNullValue.isEmpty) {
                                return (AppStrings.passwordIsRequired);
                              } else if (passNonNullValue.length < 4) {
                                return (AppStrings.loginPasswordMustBe);
                              }

                              return null;
                            },
                            textInputType: TextInputType.number,
                            hintText: AppStrings.enterPassword,
                            borderColor: AppColors.loginFieldStorke,
                            labelStyle: AppTextStyle.body1.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.loginLabelText),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                          colors: AppColors.blue,
                          onPressed: () async {
                            if (fromKey.currentState!.validate()) {
                              _loginCtrl.loginCtrl.clear();
                              if (isOccupied) {
                                Get.back();

                                statusDailog();
                                playSampleSound();
                              } else {
                                Get.back();
                                statusAVDailog();
                              }
                            }
                          },
                          title: "Enter",
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  statusDailog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // title: const Text("Login"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,

          content: StreamBuilder(
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
                return SizedBox(
                  height: 200,
                  width: 400,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.volume_up,
                        size: 100,
                        color: AppColors.blue,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Button(
                        colors: AppColors.blue,
                        onPressed: () async {
                          // await firestoreService!
                          //     .updateOccuipency(id, isOccupied);
                          Get.back();
                          stopSound();
                          // _loginCtrl.loginCtrl.clear();
                          // statusDailog();
                        },
                        title: "Cancel",
                      )
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  statusAVDailog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // title: const Text("Login"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,

          content: StreamBuilder(
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
                return SizedBox(
                  height: 250,
                  width: 400,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomImageProvider(
                        image: "assets/images/cleaning.jpg",
                        height: 130,
                        widht: 200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Cleaning is Progress",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Button(
                        colors: AppColors.blue,
                        onPressed: () async {
                          // await firestoreService!
                          //     .updateOccuipency(id, isOccupied);
                          Get.back();
                          stopSound();
                          // _loginCtrl.loginCtrl.clear();
                          // statusDailog();
                        },
                        title: "Done",
                      )
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPlayer = false;
    initializeDateFormatting();
    print("object");
    firestoreService = CloudFirestoreService(FirebaseFirestore.instance);
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    // WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      // drawer: const Drawer(),
      body: PaddingWidget(
        child: StreamBuilder(
          // call `getUsers` which return a Stream
          stream: firestoreService!.getUsers(),
          builder: (context, snapshot) {
            // connetion();
            // check our connection (loading|error)

            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error fetching data: ${snapshot.data}');
            } else if (snapshot.hasData &&
                snapshot.data!.docs.isEmpty == true) {
              return const Center(child: Text('Empty documents'));
            }
            // `data?.docs` return a [List<QueryDocumentSnapshot>]
            // we're going to return a [ListView.builder] with those documents data
            final documents = snapshot.data?.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: documents!.length,
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     childAspectRatio: 1.2,
              //     mainAxisSpacing: 10,
              //     crossAxisSpacing: 10,
              //     crossAxisCount: 1),
              itemBuilder: (context, index) {
                // int temp = int.parse(documents[index]["color"]);
                // Color color = Color(int.parse(
                //         documents[index]["color"].substring(1, 7),
                //         radix: 16) +
                //     0xFF000000);
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          washroom: documents[index],
                        ),
                      ));
                      // showDailog(
                      //     documents[index].id, documents[index]["occupied"]);
                    },
                    child:
                    // ListTile(
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    //   //    collapsedIconColor: AppColors.white,
                    //   iconColor: AppColors.yellow,
                    //
                    //   // trailing: Icon(
                    //   //   Icons.arrow_drop_down,
                    //   //   color: AppColors.white,
                    //   // ),
                    //   title: Center(
                    //     child: Text(
                    //       documents[index]["status"]!,
                    //       style: AppTextStyle.heading2,
                    //     ),
                    //   ),
                    //   //   children: [
                    // )
                     Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            CustomImageProvider(
                              image: "assets/images/washroom.png",
                              height: 150,
                              widht: double.infinity,
                            ),
                            Text(
                              documents[index]["title"]!,
                              style: AppTextStyle.heading2.copyWith(
                                color: AppColors.black
                              ),
                            ),
                            const SizedBox(
                              height: AppSize.s10,
                            ),

                            Row(
                              children: [
                                const Text(
                                  "Status",
                                  // style:
                                  style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.black),
                                ),
                                const Spacer(),
                                documents[index]["occupied"]!
                                    ? const Text(
                                        "Some stall in use",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.red),
                                      )
                                    : const Text(
                                        "Restroom Available",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.green),
                                      )
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     const Text(
                            //       "Status",
                            //       style: AppTextStyle.body1,
                            //     ),
                            //     const Spacer(),
                            //     CircleAvatar(
                            //         radius: 7,
                            //         foregroundColor: color,

                            //         // Color(0xff + temp),
                            //         backgroundColor: color
                            //         //     washroomList[index].statusColor,
                            //         ),
                            //     const SizedBox(
                            //       width: AppSize.s4,
                            //     ),
                            //     Text(
                            //       documents[index]["status"]!,
                            //       style: AppTextStyle.body2Medium,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            // documents[index]["status"]! == "Empty"
                            //     ? Button(
                            //         colors: AppColors.blue,
                            //         onPressed: () {
                            //           var dateString =
                            //               format.format(DateTime.now());

                            //           if (documents
                            //               .where(
                            //                   (e) => e["status"] == "In Progress")
                            //               .toList()
                            //               .isNotEmpty) {
                            //             Get.showSnackbar(
                            //               const GetSnackBar(
                            //                 title: "Can't clean",
                            //                 message:
                            //                     "You cannot start cleaning if already one In Progress",
                            //                 // icon: Icon(Icons.refresh),
                            //                 duration: Duration(seconds: 3),
                            //               ),
                            //             );
                            //           } else if (documents[index]["status"] ==
                            //               "Empty") {
                            //             firestoreService!.updateWashroom(
                            //                 documents[index].id,
                            //                 "In Progress",
                            //                 dateString,
                            //                 "#FFFF00");
                            //           }
                            //         },
                            //         title: "Start Cleaning",
                            //       )
                            //     : documents[index]["status"] == "In Progress"
                            //         ? Button(
                            //             colors: AppColors.red,
                            //             onPressed: () async {
                            //               var exit =
                            //                   format.format(DateTime.now());
                            //               var start =
                            //                   documents[index]["start_time"];
                            //               var parsedExit =
                            //                   DateFormat("hh:mm:ss").parse(exit);

                            //               var parsedDate =
                            //                   DateFormat("hh:mm:ss").parse(start);

                            //               print(parsedExit
                            //                   .difference(parsedDate)
                            //                   .inMinutes);
                            //               if (parsedExit
                            //                       .difference(parsedDate)
                            //                       .inMinutes <=
                            //                   2) {
                            //                 Get.showSnackbar(
                            //                   const GetSnackBar(
                            //                     title: "Wait",
                            //                     message:
                            //                         "You cannot exit before 2 min",
                            //                     icon: Icon(Icons.refresh),
                            //                     duration: Duration(seconds: 3),
                            //                   ),
                            //                 );
                            //               } else if (documents[index]
                            //                       ["status"]! ==
                            //                   "In Progress") {
                            //                 await firestoreService!
                            //                     .exitWashroom(documents[index].id,
                            //                         "Cleaned", exit, "#87CEEB")
                            //                     .then((e) {
                            //                   showBottom(
                            //                     documents[index].id,
                            //                   );
                            //                 });
                            //               }

                            //               //
                            //             },
                            //             title: "Exit",
                            //           )
                            //         :
                            //  Button(
                            //     colors: AppColors.red,
                            //     onPressed: () {
                            //       showBottom(
                            //         documents[index].id,
                            //       );
                            //     },
                            //     title: "Bottom",
                            //   ),
                            // const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    );
              },
            );
          },
        ),
      ),
    );

    // );
  }

  showBottom(String id) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return SizedBox(
            height: 340,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // shrinkWrap: true,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: AppSize.s60,
                  ),

                  // showPlayer
                  //     ?
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25),
                  //   child: AudioPlayer(
                  //     source: "https://example.com/my-audio.wav",
                  //     onDelete: () {
                  //       setState(() => showPlayer = false);
                  //     },
                  //   ),
                  // ),
                  //     : SizedBox(
                  //         height: 100,
                  //         child: Recorder(
                  //           onStop: (path) {
                  //             if (kDebugMode)
                  //               print('Recorded file path: $path');
                  //             setState(() {
                  //               audioPath = path;
                  //               showPlayer = true;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),

                  // StreamBuilder<BluetoothState>(
                  //     stream: FlutterBlue.instance.state,
                  //     initialData: BluetoothState.unknown,
                  //     builder: (c, snapshot) {
                  //       final state = snapshot.data;
                  //       if (state == BluetoothState.on) {
                  //         return ElevatedButton(
                  //             style: ElevatedButton.styleFrom(
                  //                 backgroundColor: Colors.white),
                  //             onPressed: () {
                  //               FlutterBlue.instance.startScan(
                  //                   timeout: const Duration(seconds: 4));
                  //               Navigator.of(context).push(MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     const FindDevicesScreen(),
                  //               ));
                  //             },
                  //             child: const Text("Scan Bluetooth"));

                  //         // FindDevicesScreen();
                  //       }
                  //       return const Text(
                  //           "Bluetooth is turn off Please turn On ");

                  //       // BluetoothOffScreen(state: state);
                  //     }),

                  // Obx(
                  //   () =>
                  //       dashCtrl.adapterState.value == BluetoothAdapterState.on
                  //           ? ElevatedButton(
                  //               style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.white),
                  //               onPressed: () {
                  //                 Navigator.of(context).push(MaterialPageRoute(
                  //                   builder: (context) => ScanScreen(),
                  //                 ));
                  //               },
                  //               child: Text("Scan Bluetooth"))
                  //           //const ScanScreen()
                  //           : ElevatedButton.icon(
                  //               style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.white),
                  //               label: const Text("Turn On Bluetooth"),
                  //               icon: const Icon(Icons.bluetooth),
                  //               onPressed: () async {
                  //                 try {
                  //                   if (Platform.isAndroid) {
                  //                     await FlutterBluePlus.turnOn();
                  //                   }
                  //                 } catch (e) {
                  //                   Get.showSnackbar(
                  //                     GetSnackBar(
                  //                       title: "Wait",
                  //                       message: "Error Turning On: $e",
                  //                       icon: const Icon(Icons.refresh),
                  //                       duration: const Duration(seconds: 3),
                  //                     ),
                  //                   );
                  //                 }
                  //               },
                  //               //child: const Text("Bluetooth turn on")
                  //             ),
                  // ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Button(
                    colors: AppColors.blue,
                    onPressed: () async {
                      // if (audioPath == null || audioPath!.isEmpty) {
                      //   Get.showSnackbar(
                      //     const GetSnackBar(
                      //       title: "Please Record Announcement ",
                      //       message:
                      //           "Please record Announcement to make announcement",
                      //       icon: Icon(Icons.mic),
                      //       duration: Duration(seconds: 3),
                      //     ),
                      //   );
                      // } else {
                      playSampleSound();
                      //.then((c) => stopSound());
                      var dateString = format.format(DateTime.now());
                      // await firestoreService!
                      //     .announmentTime(id, dateString)
                      //     .then(
                      //   (value) {
                      //     Get.back();
                      //     // stopSound();
                      //   },
                      // );
                      // }
                    },
                    title: "Announcement ",
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
