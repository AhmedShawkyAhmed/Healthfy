import 'package:healthify/src/data/resonses/my_package_response_data.dart';

class MyPackageResponse {
  String? message;
  MyPackageResponseData? data;

  MyPackageResponse({
    this.message,
    this.data,
  });
  factory MyPackageResponse.fromJson(Map<String, dynamic> json) => MyPackageResponse(
    message: json['message'] ?? "",
    data: json["data"] != null && json['data'] is! List
        ? MyPackageResponseData.fromJson(json["data"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
  };
}
