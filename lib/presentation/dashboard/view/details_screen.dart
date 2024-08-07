import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:woloo/config/app_color.dart';
import 'package:woloo/config/app_textstyle.dart';
import 'package:woloo/utils/helpers/Image_provider.dart';
import 'package:woloo/utils/ui/button.dart';

import '../../../core/network/firebase_service.dart';
import '../../../utils/resources/string_manager.dart';
import '../../../utils/ui/textfield.dart';
import '../../authentication/controller/authController.dart';

class DetailsScreen extends StatefulWidget {
  QueryDocumentSnapshot<Map<String, dynamic>>? washroom;
  DetailsScreen({super.key, this.washroom});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  CloudFirestoreService? firestoreService;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firestoreService = CloudFirestoreService(FirebaseFirestore.instance);

  }
  var format = DateFormat('hh:mm:ss');
  var dateFormat = DateFormat('yyyy-MM-dd');
  final _loginCtrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: AppColors.white,
        ),
        actions: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: ElevatedButton(

                 onPressed: (){
                   showDailog(widget.washroom!["occupied"]);
                 }, child:  Text("Login",
               style:  TextStyle(
                 color: AppColors.black
               ) ,
             ) ),
           )
        ],
        backgroundColor: AppColors.grey,
        // title: Text(
        //   widget.washroom!["title"],
        //   style: AppTextStyle.heading1,
        // ),
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const CustomImageProvider(
                image: "assets/images/washroom.png",
              ),
              const Divider(
                color: AppColors.yellow,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {

                 // widget.washroom!["occupied"]
                  // ? statusDailog()
                  // : statusAVDailog();
                },
                child: Container(
                  width: double.infinity,
                  height: 70,
                  color:
                  widget.washroom!["occupied"]
        
                  // widget![0]["status"] == "Unoccupied"
                  ?
                  AppColors.red
                      :
                  AppColors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          widget.washroom!["title"],
                          style: AppTextStyle.heading2,
                        ),
                        const Spacer(),
                        // widget.washroom!["status"]!
                        //     ? const Text(
                        //         "Some stall in use",
                        //         style: TextStyle(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.bold,
                        //             color: AppColors.red),
                        //       )
                        //     : const Text(
                        //         "Restroom Available",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             color: AppColors.green),
                        //       )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )

      // StreamBuilder(
      //   stream:  firestoreService!.getUsers(),
      //   builder: (context, snapshot) {
      //
      //     if (snapshot.connectionState == ConnectionState.waiting ||
      //         snapshot.connectionState == ConnectionState.none) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Text('Error fetching data: ${snapshot.data}');
      //     } else if (snapshot.hasData &&
      //         snapshot.data!.docs.isEmpty == true) {
      //       return const Center(child: Text('Empty documents'));
      //     }
      //     // `data?.docs` return a [List<QueryDocumentSnapshot>]
      //     // we're going to ret urn a [ListView.builder] with those documents data
      //     final documents = snapshot.data?.docs;
      //     print(documents!.first.id);
      //      print(documents!.first["status"]);
      //      // EPQdf5TmMsUBoUetTvWj
      //     return
      //       Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Column(
      //         // crossAxisAlignment: CrossAxisAlignment.center,
      //         // mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           const SizedBox(
      //             height: 140,
      //           ),
      //           const CustomImageProvider(
      //             image: "assets/images/washroom.png",
      //           ),
      //           const Divider(
      //             color: AppColors.yellow,
      //           ),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           InkWell(
      //             onTap: () {
      //           //    showDailog(widget.washroom!["status"]);
      //
      //               // ? statusDailog()
      //               // : statusAVDailog();
      //             },
      //             child: Container(
      //               width: double.infinity,
      //               height: 70,
      //               color:
      //               documents![0]["status"] == "Unoccupied" ?
      //                    AppColors.green
      //               :
      //               AppColors.red,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(16.0),
      //                 child: Row(
      //                   children: [
      //                      Text(
      //                       documents.first["status"],
      //                       style: AppTextStyle.heading2,
      //                     ),
      //                     const Spacer(),
      //                     // widget.washroom!["status"]!
      //                     //     ? const Text(
      //                     //         "Some stall in use",
      //                     //         style: TextStyle(
      //                     //             fontSize: 16,
      //                     //             fontWeight: FontWeight.bold,
      //                     //             color: AppColors.red),
      //                     //       )
      //                     //     : const Text(
      //                     //         "Restroom Available",
      //                     //         style: TextStyle(
      //                     //             fontWeight: FontWeight.bold,
      //                     //             color: AppColors.green),
      //                     //       )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   }
      // ),
    );
  }

  final fromKey = GlobalKey<FormState>();
  late AudioPlayer player = AudioPlayer();
  Future playSampleSound() async {
    await player.setSource(AssetSource('sample.mp3'));
    await player.resume();
  }

  void stopSound() async {
    await player.stop();
  }

  showDailog(bool isOccupied) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: AppColors.grey,
            // title: const Text("Login"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            // actions: [
            //   ElevatedButton(onPressed: () {}, child: const Text("Back")),
            //   ElevatedButton(onPressed: () {}, child: const Text("Next")),
            // ],
            content:
                //  StreamBuilder(

                SizedBox(
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
                        borderColor: AppColors.yellow,
                        labelStyle: AppTextStyle.body1.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                      colors: AppColors.yellow,
                      onPressed: () async {
                        var timeString = format.format(DateTime.now());
                        var dateString = dateFormat.format(DateTime.now());
                         firestoreService!.loginWashroom(widget.washroom!.id, timeString, dateString);
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
            )
            // }),
            );
      },
    );
  }

  statusDailog() {
   return showDialog(
      context: context,
      builder: (context) {
         print(widget.washroom!.id);
        Future.delayed(Duration(seconds: 5), ()async {

          var timeString = format.format(DateTime.now());
              var dateString = dateFormat.format(DateTime.now());
              await  firestoreService!.announmentTime(widget.washroom!.id, timeString,dateString);
               await   firestoreService!.updateWashroom(widget.washroom!.id, false);

               Navigator.of(context).pop(true);
               Navigator.of(context).pop(true);
          //     Get.back();
          //     stopSound();
        });
        return AlertDialog(
            backgroundColor: AppColors.grey,
            // title: const Text("Login"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            content:
                //  StreamBuilder(

                SizedBox(
              height: 200,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.volume_up,
                    size: 100,
                    color: AppColors.yellow,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Button(
                  //   colors: AppColors.yellow,
                  //   onPressed: () async {
                  //     // await firestoreService!
                  //     //     .updateOccuipency(id, isOccupied);
                  //     var timeString = format.format(DateTime.now());
                  //     var dateString = dateFormat.format(DateTime.now());
                  //     await  firestoreService!.announmentTime(widget.washroom!.id, timeString,dateString);
                  //     Get.back();
                  //     stopSound();
                  //     // _loginCtrl.loginCtrl.clear();
                  //     // statusDailog();
                  //   },
                  //   title: "Cancel",
                  // )
                ],
              ),
            )
            // }),
            );
      },
    );
  }

  statusAVDailog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.grey,
          // title: const Text("Login"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,

          content:
              // StreamBuilder(

              SizedBox(
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
                  style: TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Button(
                  colors: AppColors.yellow,
                  onPressed: () async {
                    // await firestoreService!
                    //     .updateOccuipency(id, isOccupied);
                    Get.back();

                    var timeString = format.format(DateTime.now());
                    var dateString = dateFormat.format(DateTime.now());
                  await  firestoreService!.exitWashroom(widget.washroom!.id, dateString,timeString);
                    stopSound();
                    // _loginCtrl.loginCtrl.clear();
                    // statusDailog();
                  },
                  title: "Done",
                )
              ],
            ),
            // );
            // }
          ),
        );
      },
    );
  }
}
