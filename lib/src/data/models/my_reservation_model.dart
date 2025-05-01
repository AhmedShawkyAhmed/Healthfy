import 'package:healthify/src/data/shared_models/service_model.dart';

import '../shared_models/medicine_type_model.dart';

class MyReservationModel {
  int? id;
  int? medicalTypeId;
  ServiceModel? service;
  List<ServiceModel>? additionalService;
  String? date;
  String? time;
  String? status;
  num? price;
  num? discount;
  num? priceAfterDiscount;
  num? tax;
  num? totalPrice;
  MedicineTypeModel? medicineTypeModel;

  MyReservationModel({
    this.medicineTypeModel,
    this.additionalService,
    this.id,
    this.price,
    this.date,
    this.status,
    this.discount,
    this.medicalTypeId,
    this.priceAfterDiscount,
    this.service,
    this.tax,
    this.time,
    this.totalPrice,
  });

  factory MyReservationModel.fromJson(Map<String, dynamic> json) =>
      MyReservationModel(
        id: json['id'] ?? 0,
        medicalTypeId: json['medicine_type_id'] ?? 0,
        additionalService: json['additional_services'] != null
            ? (json['additional_services'] as List)
                .map((e) => ServiceModel.fromJson(e))
                .toList()
            : null,
        service: json['service_id'] != null
            ? ServiceModel.fromJson(json['service_id'])
            : null,
        price: json['price'] ?? 0,
        discount: json['discount'] ?? 0,
        priceAfterDiscount: json['price_after_discount'] ?? 0,
        tax: json['tax'] ?? 0,
        totalPrice: json['total_price'] ?? 0,
        date: json['date'] ?? "",
        time: json['time'] ?? "",
        status: json['status'] ?? "",
        medicineTypeModel: json["medicine_type"] != null
            ? MedicineTypeModel.fromJson(json["medicine_type"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'medicine_type_id': medicalTypeId,
        'additional_services':
            additionalService?.map((e) => e.toJson()).toList(),
        'service_id': service?.toJson(),
        'date': date,
        'time': time,
        'price': price,
        'discount': discount,
        'status': status,
        'price_after_discount': priceAfterDiscount,
        'tax': tax,
        'total_price': totalPrice,
        'medicine_type': medicineTypeModel?.toJson(),
      };
}
