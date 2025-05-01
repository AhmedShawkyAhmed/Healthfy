part of 'medicine_type_cubit.dart';

@immutable
abstract class MedicineTypeState {}

class MedicineTypeInitial extends MedicineTypeState {}

class MedicineTypeGetCategoriesLoadingState extends MedicineTypeState{}
class MedicineTypeGetCategoriesSuccessState extends MedicineTypeState{}
class MedicineTypeGetCategoriesFailureState extends MedicineTypeState{}

class MedicineTypeGetSpecialtiesLoadingState extends MedicineTypeState{}
class MedicineTypeGetSpecialtiesSuccessState extends MedicineTypeState{}
class MedicineTypeGetSpecialtiesFailureState extends MedicineTypeState{}

class MedicineTypeGetTypesLoadingState extends MedicineTypeState{}
class MedicineTypeGetTypesSuccessState extends MedicineTypeState{}
class MedicineTypeGetTypesFailureState extends MedicineTypeState{}

class MedicineTypeSearchTypesLoadingState extends MedicineTypeState{}
class MedicineTypeSearchTypesSuccessState extends MedicineTypeState{
  final bool end;

  MedicineTypeSearchTypesSuccessState(this.end);
}
class MedicineTypeSearchTypesFailureState extends MedicineTypeState{}

class MedicineTypeUpdateSelectedModelState extends MedicineTypeState{}

class MedicineTypeUpdateFavState extends MedicineTypeState{}

class MedicineTypeIncreaseSpecialtyFrequencyLoadingState extends MedicineTypeState{}
class MedicineTypeIncreaseSpecialtyFrequencySuccessState extends MedicineTypeState{}
class MedicineIncreaseSpecialtyFrequencyFailureState extends MedicineTypeState{}