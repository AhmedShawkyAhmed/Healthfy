class SearchMedicineTypeRequest {
  final num? lat;
  final num? lng;
  final num? discount;
  final num? nearest;
  final num? notCashe;
  final num? paymentFeature;
  final List<num>? specialties;
  final String? name;
  final num page;

  const SearchMedicineTypeRequest({
    this.notCashe,
    this.lat,
    this.lng,
    this.discount,
    this.nearest,
    this.specialties,
    this.paymentFeature,
    this.name,
    required this.page,
  });

  SearchMedicineTypeRequest copyWith({
    required final num page,
  }) {
    return SearchMedicineTypeRequest(
      notCashe: notCashe,
      lat: lat,
      lng: lng,
      discount: discount,
      nearest: nearest,
      specialties: specialties,
      name: name,
      page: page,
    );
  }

  Map<String, dynamic> toJson() => {
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
        if (discount != null) 'discount': discount,
        if (nearest != null) 'nearest': nearest,
        if (notCashe != null) 'installment_feature': notCashe,
        if (specialties != null) 'specialties': specialties,
        if (paymentFeature != null) 'payment_feature': paymentFeature,
        if (name != null) 'name': name,
        'page': page,
        'per_page': 10,
      };
}
