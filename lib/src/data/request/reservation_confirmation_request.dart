class ReservationConfirmationRequest {
  final num medicineTypeId;
  final num? reservationId;
  final num price;
  final num payment;
  final num latitude;
  final num longitude;
  final num? serviceId;
  final num? useRewardPoint;
  final String? coupon;

  const ReservationConfirmationRequest({
    required this.medicineTypeId,
    required this.reservationId,
    required this.price,
    required this.payment,
    required this.latitude,
    required this.longitude,
    required this.serviceId,
    required this.useRewardPoint,
    required this.coupon,
  });

  Map<String, dynamic> toJson() => {
        "medicine_type_id": medicineTypeId,
        "reservations_id": reservationId,
        "price": price,
        "payment": payment,
        "Location": {
          "latitude": latitude,
          "longitude": longitude,
        },
        'service_id': serviceId,
        'use_reward_point': useRewardPoint,
        'coupon': coupon,
      };
}
