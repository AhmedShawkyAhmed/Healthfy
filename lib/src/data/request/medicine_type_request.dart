class MedicineTypeRequest {
  final num? lng;
  final num? lat;
  final String type;
  final num rate;
  final num discount;
  final num installmentFeature;
  final num nearest;
  final num paymentFeature;
  final num? cityId;
  final num? regionId;
  final num? specialtyId;

  const MedicineTypeRequest({
    this.lng,
    this.lat,
    required this.type,
    required this.rate,
    required this.discount,
    required this.installmentFeature,
    required this.nearest,
    required this.paymentFeature,
    this.cityId,
    this.regionId,
    this.specialtyId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (nearest == 1 && lng != null) 'lng': lng,
      if (nearest == 1 && lat != null) 'lat': lat,
      'type': type,
      'rate': rate,
      'discount': discount,
      'installment_feature': installmentFeature,
      'nearest': nearest,
      'payment_feature': paymentFeature,
      if (nearest == 0 && cityId != null) 'city_id': cityId,
      if (nearest == 0 && regionId != null) 'regions_id': regionId,
      if (specialtyId != null) 'specialties_id': specialtyId,
    };
  }
}
