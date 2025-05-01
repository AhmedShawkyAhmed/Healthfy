import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthify/src/data/models/category_model.dart';
import 'package:healthify/src/data/models/my_reservation_model.dart';
import 'package:healthify/src/data/request/search_medicine_type_request.dart';
import 'package:healthify/src/data/request/verify_phone_request.dart';
import 'package:healthify/src/data/shared_models/medicine_type_model.dart';
import 'package:healthify/src/data/shared_models/specialty_model.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/router/reservation_argumentd.dart';
import 'package:healthify/src/presentation/screens/account/about_app_screen.dart';
import 'package:healthify/src/presentation/screens/account/account_settings_screen.dart';
import 'package:healthify/src/presentation/screens/account/delivery_location_details_screen.dart';
import 'package:healthify/src/presentation/screens/account/delivery_locations_screen.dart';
import 'package:healthify/src/presentation/screens/account/favourite_screen.dart';
import 'package:healthify/src/presentation/screens/account/select_location_screen.dart';
import 'package:healthify/src/presentation/screens/account/terms_screen.dart';
import 'package:healthify/src/presentation/screens/auth/login_screen.dart';
import 'package:healthify/src/presentation/screens/auth/register_basic_info_screen.dart';
import 'package:healthify/src/presentation/screens/auth/register_done_screen.dart';
import 'package:healthify/src/presentation/screens/auth/verification_screen.dart';
import 'package:healthify/src/presentation/screens/charge_balance_screen.dart';
import 'package:healthify/src/presentation/screens/doctor_screen.dart';
import 'package:healthify/src/presentation/screens/home/filter_screen.dart';
import 'package:healthify/src/presentation/screens/home/home_screen.dart';
import 'package:healthify/src/presentation/screens/hospital_screen.dart';
import 'package:healthify/src/presentation/screens/insurance/annual_insurance_screen.dart';
import 'package:healthify/src/presentation/screens/insurance/family_insurance_screen.dart';
import 'package:healthify/src/presentation/screens/insurance/family_married_insurane_screen.dart';
import 'package:healthify/src/presentation/screens/my_reservation_screen.dart';
import 'package:healthify/src/presentation/screens/onboarding_screen.dart';
import 'package:healthify/src/presentation/screens/qr_code/booking_discount_screen.dart';
import 'package:healthify/src/presentation/screens/qr_code/booking_done_screen.dart';
import 'package:healthify/src/presentation/screens/qr_code/insert_additional_services_screen.dart';
import 'package:healthify/src/presentation/screens/qr_code/qr_code_done_screen.dart';
import 'package:healthify/src/presentation/screens/qr_code/qr_code_screen.dart';
import 'package:healthify/src/presentation/screens/splash_screen.dart';
import 'package:healthify/src/presentation/screens/web_view_screen.dart';
import 'package:healthify/src/presentation/views/xray_details_views/pdf_reader_view.dart';

import '../screens/add_rating_screen.dart';
import '../screens/add_visa_screen.dart';
import '../screens/cities_screen.dart';
import '../screens/customers_rating_screen.dart';
import '../screens/ended_reservation_screen.dart';
import '../screens/home/clinics_screen.dart';
import '../screens/insurance/family_single_insurance_screen.dart';
import '../screens/insurance/individual_insurance_screen.dart';
import '../screens/insurance/insurance_details_screen.dart';
import '../screens/insurance/insurance_done_screen.dart';
import '../screens/medical_record_screen.dart';
import '../screens/partners_screen.dart';
import '../screens/points_screen.dart';
import '../screens/regions_screen.dart';
import '../screens/search_area_doctors_screen.dart';
import '../screens/specialist_doctors_screen.dart';
import '../screens/xray_details_screen.dart';
import '../screens/your_health_care_screen.dart';
import 'history_arguments.dart';
import 'hospital_arguments.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterNames.rSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case AppRouterNames.rOnBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnBoarding(),
        );
      case AppRouterNames.rLogin:
        return MaterialPageRoute(
          builder: (_) => const Login(),
        );
      case AppRouterNames.rVerification:
        final request = settings.arguments as VerifyPhoneRequest;
        return MaterialPageRoute(
          builder: (_) => VerificationScreen(
            request: request,
          ),
        );
      case AppRouterNames.rRegisterBasicInfo:
        return MaterialPageRoute(
          builder: (_) => const RegistrationBasic(),
        );
      case AppRouterNames.rRegisterDone:
        return MaterialPageRoute(
          builder: (_) => const Done(),
        );
      case AppRouterNames.rHome:
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      case AppRouterNames.rAccountSettings:
        return MaterialPageRoute(
          builder: (_) => const AccountSettingsScreen(),
        );
      case AppRouterNames.rInsertAdditionalServices:
        final myReservation = settings.arguments as MyReservationModel;
        return MaterialPageRoute(
          builder: (_) => InsertAdditionalServicesScreen(
            myReservation: myReservation,
          ),
        );
      case AppRouterNames.rFavourites:
        return MaterialPageRoute(
          builder: (_) => const FavouriteScreen(),
        );
      case AppRouterNames.rAbout:
        return MaterialPageRoute(
          builder: (_) => const AboutAppScreen(),
        );
      case AppRouterNames.rDeliveryLocations:
        return MaterialPageRoute(
          builder: (_) => const DeliveryLocationsScreen(),
        );
      case AppRouterNames.rLocationSelect:
        return MaterialPageRoute(
          builder: (_) => const SelectLocationScreen(),
        );
      case AppRouterNames.rDeliveryLocationDetails:
        final args = settings.arguments as List;
        return MaterialPageRoute(
          builder: (_) => DeliveryLocationDetailsScreen(
            location: args[0] as LatLng,
            locationAddress: args[1] as Placemark,
          ),
        );

      case AppRouterNames.rQrcodeScan:
        final type = settings.arguments as ReservationArguments;
        return MaterialPageRoute(
          builder: (_) => QrCodeScreen(
            reservationArguments: type,
          ),
        );
      case AppRouterNames.rQrcodeScanDone:
        return MaterialPageRoute(
          builder: (_) => const QrCodeDoneScreen(),
        );
      case AppRouterNames.rBookingDiscount:
        final reservationArguments = settings.arguments as ReservationArguments;
        return MaterialPageRoute(
          builder: (_) => BookingDiscountScreen(
            reservationArguments: reservationArguments,
          ),
        );
      case AppRouterNames.rBookingDone:
        final title = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BookingDoneScreen(title: title),
        );
      case AppRouterNames.rInsuranceCard:
        return MaterialPageRoute(
          builder: (_) => const AnnualInsuranceScreen(),
        );
      case AppRouterNames.rIndividualInsurance:
        return MaterialPageRoute(
          builder: (_) => const IndividualInsuranceScreen(),
        );
      case AppRouterNames.rFamilyInsurance:
        return MaterialPageRoute(
          builder: (_) => const FamilyInsuranceScreen(),
        );
      case AppRouterNames.rFamilyInsuranceSingle:
        return MaterialPageRoute(
          builder: (_) => const FamilySingleInsuranceScreen(),
        );
      case AppRouterNames.rFamilyInsuranceMarried:
        return MaterialPageRoute(
          builder: (_) => const FamilyMarriedInsuranceScreen(),
        );
      case AppRouterNames.rAddPayment:
        return MaterialPageRoute(
          builder: (_) => const AddVisaScreen(),
        );
      case AppRouterNames.rInsuranceDone:
        final list = settings.arguments as List<String>;
        final startDate = list[0];
        final endDate = list[1];
        return MaterialPageRoute(
          builder: (_) => InsuranceDoneScreen(
            startDate: startDate,
            endDate: endDate,
          ),
        );
      case AppRouterNames.rInsuranceDetails:
        return MaterialPageRoute(
          builder: (_) => const InsuranceDetailsScreen(),
        );
      case AppRouterNames.rChargeBalance:
        final link = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ChargeBalanceScreen(
            link: link,
          ),
        );
      case AppRouterNames.rPoints:
        return MaterialPageRoute(
          builder: (_) => const PointsScreen(),
        );
      case AppRouterNames.rPartners:
        return MaterialPageRoute(
          builder: (_) => const PartnersScreen(),
        );
      case AppRouterNames.rRates:
        return MaterialPageRoute(
          builder: (_) => const CustomersRatingScreen(),
        );
      case AppRouterNames.rAddRate:
        return MaterialPageRoute(
          builder: (_) => const AddRatingScreen(),
        );
      case AppRouterNames.rYourHealthCare:
        final String type = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => YourHealthCareScreen(
            type: type,
          ),
        );
      case AppRouterNames.rMedicalRecord:
        return MaterialPageRoute(
          builder: (_) => const MedicalRecordScreen(),
        );
      case AppRouterNames.rXRayDetails:
        final medicalHistoryModel = settings.arguments as HistoryArguments;
        return MaterialPageRoute(
          builder: (_) => XRayDetailsScreen(
            medicalHistoryModel: medicalHistoryModel,
          ),
        );
      case AppRouterNames.rPDFView:
        final PlatformFile file = settings.arguments as PlatformFile;
        return MaterialPageRoute(
          builder: (_) => PDFReaderView(file: file),
        );
      case AppRouterNames.rClinics:
        final category = settings.arguments as CategoryModel;
        return MaterialPageRoute(
          builder: (_) => ClinicsScreen(
            category: category,
          ),
        );
      case AppRouterNames.rTerms:
        return MaterialPageRoute(
          builder: (_) => const TermsScreen(),
        );
      case AppRouterNames.rLocationCities:
        final args = settings.arguments as List;
        return MaterialPageRoute(
          builder: (_) => CityScreen(
            category: args[0] as String,
            specialty: args[1] as SpecialtyModel,
          ),
        );
      case AppRouterNames.rLocationRegions:
        final args = settings.arguments as List;
        return MaterialPageRoute(
          builder: (_) => RegionScreen(
            category: args[0] as CategoryModel,
            specialty: args[1] as SpecialtyModel?,
            //city: args[2] as CityModel,
          ),
        );
      case AppRouterNames.rSearchAreaDoctors:
        final args = settings.arguments as List;
        return MaterialPageRoute(
          builder: (_) => SearchAreaDoctorsScreen(
            category: args[0],
            specialty: args[1],
            city: args[2],
            region: args[3],
          ),
        );
      case AppRouterNames.rMyReservation:
        return MaterialPageRoute(
          builder: (_) => const MyReservationScreen(),
        );
      case AppRouterNames.rWebView:
        final data = settings.arguments as List;
        final title = data[0] as String;
        final link = data[1] as String;
        return MaterialPageRoute(
          builder: (_) => WebViewScreen(
            title: title,
            link: link,
          ),
        );
      case AppRouterNames.rEndedReservation:
        return MaterialPageRoute(
          builder: (_) => const EndedReservationScreen(),
        );
      case AppRouterNames.rSpecialistDoctors:
        final hospitalArguments = settings.arguments as HospitalArguments;
        return MaterialPageRoute(
          builder: (_) => SpecialistDoctorsScreen(
            hospitalArguments: hospitalArguments,
          ),
        );
      case AppRouterNames.rFilter:
        final request = settings.arguments as SearchMedicineTypeRequest;
        return MaterialPageRoute(
          builder: (_) => FilterScreen(
            request: request,
          ),
        );
      case AppRouterNames.rDoctorDetails:
        final type = settings.arguments as MedicineTypeModel;
        return MaterialPageRoute(
          builder: (_) => DoctorDetailsScreen(
            medicineType: type,
          ),
        );
      case AppRouterNames.rHospitalDetails:
        final type = settings.arguments as MedicineTypeModel;
        return MaterialPageRoute(
          builder: (_) => HospitalDetailsScreen(
            medicineType: type,
          ),
        );
      default:
        return null;
    }
  }
}
