import 'package:healthify/src/data/models/package_models/package_model.dart';

class PackageResponseData {
  List<PackageModel>? package;

  PackageResponseData({
    this.package,
  });

  factory PackageResponseData.fromJson(Map<String, dynamic> json) => PackageResponseData(
    package: json["package"] != null
        ? List<PackageModel>.from(
        json["package"].map((x) => PackageModel.fromJson(x)))
        : json["package"],
  );

  Map<String, dynamic> toJson() => {
    'package':List<dynamic>.from(package!.map((x) => x.toJson())),
  };
}
