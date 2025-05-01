class RateModel {
  num? id;
  num? userId;
  String? rateableType;
  String? rateableId;
  num? rate;
  String? comment;
  String? createdAt;
  String? updatedAt;

  RateModel(
      {this.id,
        this.userId,
        this.rateableType,
        this.rateableId,
        this.rate,
        this.comment,
        this.createdAt,
        this.updatedAt});

  RateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    rateableType = json['rateable_type'];
    rateableId = json['rateable_id'];
    rate = json['rate'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['rateable_type'] = rateableType;
    data['rateable_id'] = rateableId;
    data['rate'] = rate;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
