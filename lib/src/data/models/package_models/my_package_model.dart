import 'package:healthify/src/data/models/package_models/package_model.dart';

class MyPackageModel {
  int? id;
  String? startAt;
  String? endAt;
  PackageModel? myPackage;

  MyPackageModel({
    this.id,
    this.endAt,
    this.myPackage,
    this.startAt,
  });

  factory MyPackageModel.fromJson(Map<String, dynamic> json) => MyPackageModel(
    id: json['id'] ?? 0,
    startAt: json['start_at'] ?? "",
    endAt: json['end_at'] ?? "",
    myPackage: json["health_insurance_package"] != null
        ? PackageModel.fromJson(json["health_insurance_package"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'start_at': startAt,
    'end_at': endAt,
    'health_insurance_package': myPackage,
  };
}
