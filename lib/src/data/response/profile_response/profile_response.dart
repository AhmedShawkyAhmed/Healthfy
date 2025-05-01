import 'package:healthify/src/data/shared_models/user_model.dart';

part 'profile_response_data.dart';

class ProfileResponse {
  String? message;
  ProfileResponseData? data;

  ProfileResponse({this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? ProfileResponseData.fromJson(json['data']) : null;
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