import 'package:dio/dio.dart';
import 'package:healthify/src/data/shared_models/medical_file_data_model.dart';

class AddMedicalHistoryRequest {
  final num medicineTypeId;
  final String name;
  final String date;
  final List<MedicalFileData> medicalFiles;

  const AddMedicalHistoryRequest({
    required this.medicineTypeId,
    required this.name,
    required this.date,
    required this.medicalFiles,
  });

  Map<String, dynamic> toJson() => {
        'medicine_type_id': medicineTypeId,
        'name': name,
        'date': date,
        for (int i = 0; i < medicalFiles.length; i++) ...{
          "files[$i][file]": MultipartFile.fromFileSync(
            medicalFiles[i].file.path,
          ),
          "files[$i][fileType]": medicalFiles[i].fileType,
        }
      };
}
