import 'package:dio/dio.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/shared_models/medical_file_data_model.dart';

class UpdateMedicalHistoryRequest {
  final num medicineHistoryId;
  final String? name;
  final String? date;
  final List<MedicalFileData> removedFiles;
  final List<MedicalFileData> addedFiles;

  UpdateMedicalHistoryRequest({
    required this.medicineHistoryId,
    this.name,
    this.date,
    required this.removedFiles,
    required this.addedFiles,
  });

  Map<String, dynamic> toJson() => {
        "medicine_history_id": medicineHistoryId,
        if (name != null) "name": name,
        if (date != null) "date": date,
        for (int i = 0; i < removedFiles.length; i++) ...{
          "old_file_path[$i]": removedFiles[0].file.path.replaceAll(
                EndPoints.imageBaseUrlGlobal,
                "",
              ),
        },
        for (int i = 0; i < addedFiles.length; i++) ...{
          "files[$i][file]": MultipartFile.fromFileSync(
            addedFiles[i].file.path,
          ),
          "files[$i][fileType]": addedFiles[i].fileType,
        },
      };
}
