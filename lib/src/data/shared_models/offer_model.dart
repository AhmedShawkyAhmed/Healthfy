class OfferModel {
  num? id;
  num? type;
  num? healthInsurancePackageId;
  String? discount;

  OfferModel({this.id, this.type, this.healthInsurancePackageId, this.discount});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    healthInsurancePackageId = json['health_insurance_package_id'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['health_insurance_package_id'] = healthInsurancePackageId;
    data['discount'] = discount;
    return data;
  }
}
