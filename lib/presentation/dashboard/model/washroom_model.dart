import 'package:flutter/material.dart';
import 'package:woloo/config/app_color.dart';
import 'package:woloo/utils/resources/asset_manger.dart';

class WashroomModel {
  String? title;
  String? status;
  String? img;
  Color? statusColor;

  WashroomModel({this.status, this.title, this.img, this.statusColor});
}

List<WashroomModel> washroomList = [
  WashroomModel(
      img: ImageAssets.washRoom,
      title: "WashRoom 1",
      status: "Occupied",
      statusColor: AppColors.red),
  WashroomModel(
      img: ImageAssets.washRoom,
      title: "WashRoom 2",
      status: "Occupied",
      statusColor: AppColors.red),
  WashroomModel(
      img: ImageAssets.washRoom,
      title: "WashRoom 3",
      status: "Empty",
      statusColor: AppColors.green),
  WashroomModel(
      img: ImageAssets.washRoom,
      title: "WashRoom 4",
      status: "Occupied",
      statusColor: AppColors.red),
  WashroomModel(
      img: ImageAssets.washRoom,
      title: "WashRoom 5",
      status: "Empty",
      statusColor: AppColors.green),
  WashroomModel(
      img: ImageAssets.washRoom,
      title: "WashRoom 6",
      status: "Occupied",
      statusColor: AppColors.red)
];
