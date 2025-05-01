import 'package:healthify/src/data/shared_models/offer_model.dart';
import 'package:healthify/src/data/shared_models/schedule_model.dart';

class ServiceModel {
  num? id;
  String? price;
  String? discount;
  String? priceAfterDiscount;
  String? name;
  List<ScheduleModel>? schedule;
  List<OfferModel>? offer;

  ServiceModel({
    this.id,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.name,
    this.schedule,
    this.offer,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['schedule'] != null) {
      schedule = <ScheduleModel>[];
      json['schedule'].forEach((v) {
        schedule!.add(ScheduleModel.fromJson(v));
      });
    }
    if (json['Offer'] != null) {
      offer = <OfferModel>[];
      json['Offer'].forEach((v) {
        offer!.add(OfferModel.fromJson(v));
      });
    }
    id = json['id'];
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['priceAfterDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (schedule != null) {
      data['schedule'] = schedule!.map((v) => v.toJson()).toList();
    }
    if (offer != null) {
      data['Offer'] = offer!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['price'] = price;
    data['discount'] = discount;
    data['priceAfterDiscount'] = priceAfterDiscount;
    return data;
  }
}
