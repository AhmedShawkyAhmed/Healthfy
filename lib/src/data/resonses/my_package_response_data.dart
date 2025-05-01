import 'package:healthify/src/data/models/package_models/my_package_model.dart';

class MyPackageResponseData {
  MyPackageModel? myPackage;

  MyPackageResponseData({
    this.myPackage,
  });

  factory MyPackageResponseData.fromJson(Map<String, dynamic> json) =>
      MyPackageResponseData(
        myPackage:
            json["data"] != null ? MyPackageModel.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        'package': MyPackageModel,
      };
}
