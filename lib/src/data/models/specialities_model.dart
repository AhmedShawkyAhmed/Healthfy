class SpecialitiesModel {
  String? title;
  String? description;

  SpecialitiesModel({
    this.title,
    this.description,
  });

  SpecialitiesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
