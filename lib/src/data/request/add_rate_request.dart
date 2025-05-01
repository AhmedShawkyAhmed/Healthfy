class AddRateRequest {
  final num id;
  final num rate;
  final String? comment;

  const AddRateRequest({
    required this.id,
    required this.rate,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'rateable_type': "MedicineType",
      'rateable_id': id,
      'rate': rate,
      if (comment != null) 'comment': comment,
    };
  }
}
