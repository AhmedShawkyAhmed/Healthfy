
part of 'profile_response.dart';

class ProfileResponseData {
  UserModel? user;

  ProfileResponseData({this.user});

  ProfileResponseData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}