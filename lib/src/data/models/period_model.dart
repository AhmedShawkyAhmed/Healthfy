class PeriodModel {
  String? from;
  String? to;

  PeriodModel({
    this.from,
    this.to,
  });

  PeriodModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
