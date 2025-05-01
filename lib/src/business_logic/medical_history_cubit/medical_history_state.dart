part of 'medical_history_cubit.dart';

@immutable
abstract class MedicalHistoryState {}

class MedicalHistoryInitial extends MedicalHistoryState {}

class MedicalHistoryGetAllLoadingState extends MedicalHistoryState {}
class MedicalHistoryGetAllSuccessState extends MedicalHistoryState {}
class MedicalHistoryGetAllFailureState extends MedicalHistoryState {}

class MedicalHistoryCreateLoadingState extends MedicalHistoryState {}
class MedicalHistoryCreateSuccessState extends MedicalHistoryState {}
class MedicalHistoryCreateFailureState extends MedicalHistoryState {}

class MedicalHistoryUpdateLoadingState extends MedicalHistoryState {}
class MedicalHistoryUpdateSuccessState extends MedicalHistoryState {}
class MedicalHistoryUpdateFailureState extends MedicalHistoryState {}
