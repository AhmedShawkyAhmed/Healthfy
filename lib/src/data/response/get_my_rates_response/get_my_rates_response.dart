import 'package:healthify/src/data/shared_models/rate_model.dart';

part 'get_my_rates_response_data.dart';

class GetMyRatesResponse {
  GetMyRatesResponse({
    this.message,
    this.data,
  });

  GetMyRatesResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null
        ? GetMyRatesResponseData.fromJson(
            json['data'],
          )
        : null;
  }

  String? message;
  GetMyRatesResponseData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
