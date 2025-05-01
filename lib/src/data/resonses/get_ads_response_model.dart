import 'package:healthify/src/data/models/ad_model.dart';

class GetAdsResponseModel {
  String message;
  List<AdModel> ads;

  GetAdsResponseModel({
    required this.message,
    required this.ads,
  });

  factory GetAdsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAdsResponseModel(
        message: json['message'] ?? "",
        ads: json["data"] is Map && json["data"]['Ads'] != null
            ? (json["data"]['Ads'] as List)
                .map((e) => AdModel.fromJson(e))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': {
          "Ads": ads.map((e) => e.toJson()).toList(),
        },
      };
}
