part of 'services_with_discount_response.dart';

class ServicesWithDiscountResponseData {
  List<ServiceModel>? services;

  ServicesWithDiscountResponseData({this.services});

  ServicesWithDiscountResponseData.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <ServiceModel>[];
      json['services'].forEach((v) {
        services!.add(ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
