import 'package:healthify/src/data/resonses/phone_response_data.dart';

class PhoneResponse {
  String? message;
  PhoneResponseData? data;

  PhoneResponse({
    this.message,
    this.data,
  });
  factory PhoneResponse.fromJson(Map<String, dynamic> json) => PhoneResponse(
    message: json['message'] ?? "",
    data: json["data"] != null
        ? PhoneResponseData.fromJson(json["data"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
  };
}
