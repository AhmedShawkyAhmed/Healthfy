class AddMedicalHistoryResponse {
  String? message;
  List<dynamic>? data;

  AddMedicalHistoryResponse({this.message, this.data});

  AddMedicalHistoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        data!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
