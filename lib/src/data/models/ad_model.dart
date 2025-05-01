import 'dart:convert';

import 'package:healthify/src/data/shared_models/medicine_type_model.dart';

class AdModel {
  final MedicineTypeModel? medicineType;
  final String title;
  final String banner;
  final String description;
  final String key;

  const AdModel({
    this.medicineType,
    required this.title,
    required this.banner,
    required this.description,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'banner': banner,
      'description': description,
      'medicine_type': medicineType,
      'key': key,
    };
  }

  factory AdModel.fromJson(Map<String, dynamic> map) {
    return AdModel(
      medicineType: map['medicine_type'] != null
          ? MedicineTypeModel.fromJson(map['medicine_type'])
          : null,
      title: map['title'] ?? "",
      banner: map['banner'] ?? "",
      description: map['description'] ?? "",
      key: map['key'] ?? "",
    );
  }
}
