import 'package:image_picker/image_picker.dart';

class MedicalFileData {
  final XFile file;
  final String fileType;

  const MedicalFileData({
    required this.file,
    required this.fileType,
  });

  Map<String, dynamic> toJson() => {
    'file': file,
    'fileType': fileType,
  };
}