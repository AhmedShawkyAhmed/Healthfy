import 'package:healthify/src/data/shared_models/service_model.dart';

part 'services_with_discount_response_data.dart';

class ServicesWithDiscountResponse {
  String? message;
  ServicesWithDiscountResponseData? data;

  ServicesWithDiscountResponse({this.message, this.data});

  ServicesWithDiscountResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? ServicesWithDiscountResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
