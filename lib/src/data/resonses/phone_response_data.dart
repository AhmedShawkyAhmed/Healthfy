import 'package:healthify/src/data/models/app_content_models/phone_model.dart';

class PhoneResponseData {
  PhoneModel? phoneModel;

  PhoneResponseData({
    this.phoneModel,
  });

  factory PhoneResponseData.fromJson(Map<String, dynamic> json) =>
      PhoneResponseData(
        phoneModel:
        json["content"] != null ? PhoneModel.fromJson(json["content"]) : null,
      );

  Map<String, dynamic> toJson() => {
    'content': phoneModel,
  };
}
