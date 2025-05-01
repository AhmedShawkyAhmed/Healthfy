class ReserveRequest {
  final num serviceId;
  final String date;
  final String time;
  final num useRewardPoint;
  final String coupon;

  const ReserveRequest({
    required this.serviceId,
    required this.date,
    required this.time,
    required this.useRewardPoint,
    required this.coupon,
  });

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'date': date,
      'time': time,
      'use_reward_point': useRewardPoint,
      'coupon': coupon,
    };
  }
}
