import '../../data/models/my_reservation_model.dart';
import '../../data/shared_models/medicine_type_model.dart';

class ReservationArguments {
  MyReservationModel? myReservationModel;
  num? price;
  MedicineTypeModel medicineTypeModel;
  String status;
  String type;
  num? payment;
  num? serviceId;
  num? useRewardPoint;
  String? coupon;

  ReservationArguments({
    this.myReservationModel,
    this.price,
    this.payment,
    required this.medicineTypeModel,
    required this.status,
    required this.type,
    this.coupon,
    this.serviceId,
    this.useRewardPoint,
  });
}
