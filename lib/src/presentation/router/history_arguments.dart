import '../../data/models/my_reservation_model.dart';
import '../../data/shared_models/medical_history_model.dart';

class HistoryArguments {
  String type;
  MedicalHistoryModel? medicalHistoryModel;
  MyReservationModel? myReservationModel;

  HistoryArguments({
    required this.type,
    this.medicalHistoryModel,
    this.myReservationModel,
  });
}
