class MediaModel {
  int? id;
  String? mediaableType;
  int? mediaableId;
  String? filename;
  String? filetype;
  String? type;
  String? deletedAt;
  String? createByType;
  int? createById;
  String? updateByType;
  num? updateById;
  String? secondType;
  String? createdAt;
  String? updatedAt;

  MediaModel(
      {this.id,
        this.mediaableType,
        this.mediaableId,
        this.filename,
        this.filetype,
        this.type,
        this.deletedAt,
        this.createByType,
        this.createById,
        this.updateByType,
        this.updateById,
        this.secondType,
        this.createdAt,
        this.updatedAt});

  MediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaableType = json['mediaable_type'];
    mediaableId = json['mediaable_id'];
    filename = json['filename'];
    filetype = json['filetype'];
    type = json['type'];
    deletedAt = json['deleted_at'];
    createByType = json['createBy_type'];
    createById = json['createBy_id'];
    updateByType = json['updateBy_type'];
    updateById = json['updateBy_id'];
    secondType = json['Second_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mediaable_type'] = mediaableType;
    data['mediaable_id'] = mediaableId;
    data['filename'] = filename;
    data['filetype'] = filetype;
    data['type'] = type;
    data['deleted_at'] = deletedAt;
    data['createBy_type'] = createByType;
    data['createBy_id'] = createById;
    data['updateBy_type'] = updateByType;
    data['updateBy_id'] = updateById;
    data['Second_type'] = secondType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}