import '../../data/shared_models/doctor_model.dart';

class HospitalArguments {
  String name;
  List<DoctorModel> doctors;

  HospitalArguments({
    required this.name,
    required this.doctors,
  });
}
