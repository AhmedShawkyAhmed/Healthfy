import 'package:healthify/src/data/resonses/my_reservation_response_data.dart';

class MyReservationResponse {
  String? message;
  MyReservationResponseData? data;

  MyReservationResponse({
    this.message,
    this.data,
  });
  factory MyReservationResponse.fromJson(Map<String, dynamic> json) => MyReservationResponse(
    message: json['message'] ?? "",
    data: json["data"] != null
        ? MyReservationResponseData.fromJson(json["data"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
  };
}