class AddFavouriteRequest {
  final num favableId;

  const AddFavouriteRequest({
    required this.favableId,
  });

  Map<String, dynamic> toJson() => {
        'favable_type': "MedicineType",
        'favable_id': favableId,
      };
}
