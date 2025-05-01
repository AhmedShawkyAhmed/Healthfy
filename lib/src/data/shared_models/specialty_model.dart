class SpecialtyModel {
  num? id;
  String? title;
  String? description;
  num? specialtiesId;
  String? icon;

  SpecialtyModel({
    this.id,
    this.title,
    this.description,
    this.specialtiesId,
    this.icon,
  });

  SpecialtyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    specialtiesId = json['specialties_id'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['specialties_id'] = specialtiesId;
    data['icon'] = icon;
    return data;
  }
}
