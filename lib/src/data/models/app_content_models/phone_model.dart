class PhoneModel {
  int? id;
  String? content;
  String? type;

  PhoneModel({
    this.id,
    this.content,
    this.type,
  });


  factory PhoneModel.fromJson(Map<String, dynamic> json) => PhoneModel(
    id: json['id'] ?? 0,
    content: json['content'] ?? "",
    type: json['type'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'type': type,
  };
}
