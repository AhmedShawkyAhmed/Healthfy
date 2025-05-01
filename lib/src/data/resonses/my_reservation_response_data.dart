import 'package:healthify/src/data/models/my_reservation_model.dart';

class MyReservationResponseData {
  List<MyReservationModel>? myReservation;

  MyReservationResponseData({
    this.myReservation,
  });

  factory MyReservationResponseData.fromJson(Map<String, dynamic> json) => MyReservationResponseData(
    myReservation: json["reservation"] != null
        ? List<MyReservationModel>.from(
        json["reservation"].map((x) => MyReservationModel.fromJson(x)))
        : json["reservation"],
  );

  Map<String, dynamic> toJson() => {
    'reservation':List<dynamic>.from(myReservation!.map((x) => x.toJson())),
  };
}