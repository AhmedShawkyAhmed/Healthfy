part of 'get_my_rates_response.dart';

class GetMyRatesResponseData {
  List<RateModel>? rates;

  GetMyRatesResponseData({
    this.rates,
  });

  GetMyRatesResponseData.fromJson(dynamic json) {
    if (json['rates'] != null) {
      rates = [];
      json['rates'].forEach((v) {
        rates?.add(RateModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rates != null) {
      map['rates'] = rates?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
