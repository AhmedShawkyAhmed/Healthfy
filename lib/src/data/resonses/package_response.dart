import 'package:healthify/src/data/resonses/package_response_data.dart';

class PackageResponse {
  String? message;
  PackageResponseData? data;

  PackageResponse({
    this.message,
    this.data,
  });
  factory PackageResponse.fromJson(Map<String, dynamic> json) => PackageResponse(
    message: json['message'] ?? "",
    data: json["data"] != null
        ? PackageResponseData.fromJson(json["data"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
  };
}
