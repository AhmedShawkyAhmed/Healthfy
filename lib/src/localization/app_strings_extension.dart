// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const supportedLocales = AppLocalizations.supportedLocales;

extension AppStrings on BuildContext {
  bool get isAr => AppLocalizations.of(this)!.localeName == "ar";

  String get healthify => AppLocalizations.of(this)!.healthify;

  String get onBoarding1Text1 => AppLocalizations.of(this)!.onBoarding1Text1;

  String get onBoarding1Text2 => AppLocalizations.of(this)!.onBoarding1Text2;

  String get onBoarding2Text1 => AppLocalizations.of(this)!.onBoarding2Text1;

  String get onBoarding2Text2 => AppLocalizations.of(this)!.onBoarding2Text2;

  String get onBoarding3Text1 => AppLocalizations.of(this)!.onBoarding3Text1;

  String get onBoarding3Text2 => AppLocalizations.of(this)!.onBoarding3Text2;

  String get onBoarding4Text1 => AppLocalizations.of(this)!.onBoarding4Text1;

  String get onBoarding4Text2 => AppLocalizations.of(this)!.onBoarding4Text2;

  String get login => AppLocalizations.of(this)!.login;

  String get phoneNumber => AppLocalizations.of(this)!.phoneNumber;

  String get myReservation => AppLocalizations.of(this)!.myReservation;

  String get privacy1 => AppLocalizations.of(this)!.privacy1;

  String get privacy2 => AppLocalizations.of(this)!.privacy2;

  String get follow => AppLocalizations.of(this)!.follow;

  String get enterCode => AppLocalizations.of(this)!.enterCode;

  String get code => AppLocalizations.of(this)!.code;

  String get confirm => AppLocalizations.of(this)!.confirm;

  String get areYouReceived => AppLocalizations.of(this)!.areYouReceived;

  String get resend => AppLocalizations.of(this)!.resend;

  String get happy => AppLocalizations.of(this)!.happy;

  String get search => AppLocalizations.of(this)!.search;

  String get phoneCodeSelect => AppLocalizations.of(this)!.phoneCodeSelect;

  String get gallery => AppLocalizations.of(this)!.gallery;

  String get camera => AppLocalizations.of(this)!.camera;

  String get account => AppLocalizations.of(this)!.account;

  String get myAccount => AppLocalizations.of(this)!.myAccount;

  String get rewards => AppLocalizations.of(this)!.rewards;

  String pointNumber(num number) =>
      AppLocalizations.of(this)!.pointNumber(number);

  String get insuranceCard => AppLocalizations.of(this)!.insuranceCard;

  String get myAddress => AppLocalizations.of(this)!.myAddress;

  String get favourite => AppLocalizations.of(this)!.favourite;

  String get helpTitle => AppLocalizations.of(this)!.helpTitle;

  String get help => AppLocalizations.of(this)!.help;

  String get ambulance => AppLocalizations.of(this)!.ambulance;

  String get installmentFeature =>
      AppLocalizations.of(this)!.installmentFeature;

  //String get myLocation => AppLocalizations.of(this)!.myLocation;

  String get aboutApp => AppLocalizations.of(this)!.aboutApp;

  String get terms => AppLocalizations.of(this)!.terms;

  String get logout => AppLocalizations.of(this)!.logout;

  String get accountSettings => AppLocalizations.of(this)!.accountSettings;

  String get updateImage => AppLocalizations.of(this)!.updateImage;

  String get enterPhoneNumber => AppLocalizations.of(this)!.enterPhoneNumber;

  String get name => AppLocalizations.of(this)!.name;

  String get emailAddress => AppLocalizations.of(this)!.emailAddress;

  String get birthdate => AppLocalizations.of(this)!.birthdate;

  String get saveChanges => AppLocalizations.of(this)!.saveChanges;

  String get deliveryLocations => AppLocalizations.of(this)!.deliveryLocations;

  String get deliveryLocationDetails =>
      AppLocalizations.of(this)!.deliveryLocationDetails;

  String get addNewLocation => AppLocalizations.of(this)!.addNewLocation;

  String get emptyLocations => AppLocalizations.of(this)!.emptyLocations;

  String get selectYourLocation =>
      AppLocalizations.of(this)!.selectYourLocation;

  String get confirmLocation => AppLocalizations.of(this)!.confirmLocation;

  String get saveLocation => AppLocalizations.of(this)!.saveLocation;

  String get save => AppLocalizations.of(this)!.save;

  String get city => AppLocalizations.of(this)!.city;

  String get area => AppLocalizations.of(this)!.area;

  String get streetName => AppLocalizations.of(this)!.streetName;

  String get buildingNumber => AppLocalizations.of(this)!.buildingNumber;

  String get floorNumber => AppLocalizations.of(this)!.floorNumber;

  String get flatNumber => AppLocalizations.of(this)!.flatNumber;

  String get additionalInfo => AppLocalizations.of(this)!.additionalInfo;

  String get back => AppLocalizations.of(this)!.back;

  String get scanCode => AppLocalizations.of(this)!.scanCode;

  String get discount => AppLocalizations.of(this)!.discount;

  String cancel(String val) => AppLocalizations.of(this)!.cancel(val);

  String get deleteAccountConfirmationDialog =>
      AppLocalizations.of(this)!.deleteAccountConfirmationDialog;

  String get deleteAccount => AppLocalizations.of(this)!.deleteAccount;

  String get book => AppLocalizations.of(this)!.book;

  String get deleteAccountAsk => AppLocalizations.of(this)!.deleteAccountAsk;

  String get cancelBooking => AppLocalizations.of(this)!.cancelBooking;

  String get cancelService => AppLocalizations.of(this)!.cancelService;

  String get cancelServiceTime => AppLocalizations.of(this)!.cancelServiceTime;

  String get confirmBooking => AppLocalizations.of(this)!.confirmBooking;

  String get choosePayment => AppLocalizations.of(this)!.choosePayment;

  String get serviceCost => AppLocalizations.of(this)!.serviceCost;

  String get serviceCostHint => AppLocalizations.of(this)!.serviceCostHint;

  String get costAfterDiscount => AppLocalizations.of(this)!.costAfterDiscount;

  String get disclosurePrice => AppLocalizations.of(this)!.disclosurePrice;

  String get disclosurePriceHint =>
      AppLocalizations.of(this)!.disclosurePriceHint;

  String get hour => AppLocalizations.of(this)!.hour;

  String get hourHint => AppLocalizations.of(this)!.hourHint;

  String get date => AppLocalizations.of(this)!.date;

  String get dateHint => AppLocalizations.of(this)!.dateHint;

  String get services => AppLocalizations.of(this)!.services;

  String get servicesHint => AppLocalizations.of(this)!.servicesHint;

  String get address => AppLocalizations.of(this)!.address;

  String get addressHint => AppLocalizations.of(this)!.addressHint;

  String get organizationName => AppLocalizations.of(this)!.organizationName;

  String get organizationNameHint =>
      AppLocalizations.of(this)!.organizationNameHint;

  String get customerPhone => AppLocalizations.of(this)!.customerPhone;

  String get customerPhoneHint => AppLocalizations.of(this)!.customerPhoneHint;

  String get customerName => AppLocalizations.of(this)!.customerName;

  String get customerNameHint => AppLocalizations.of(this)!.customerNameHint;

  String discountAcquired(num val) =>
      AppLocalizations.of(this)!.discountAcquired(val);

  String get bookingSuccess => AppLocalizations.of(this)!.bookingSuccess;

  String get congrats => AppLocalizations.of(this)!.congrats;

  String get chooseSubscription =>
      AppLocalizations.of(this)!.chooseSubscription;

  String get andGetDiscount => AppLocalizations.of(this)!.andGetDiscount;

  String get individualInsurance =>
      AppLocalizations.of(this)!.individualInsurance;

  String get familyInsurance => AppLocalizations.of(this)!.familyInsurance;

  String get subscribeNow => AppLocalizations.of(this)!.subscribeNow;

  String get commonQuestions => AppLocalizations.of(this)!.commonQuestions;

  String get whatIsCardBenefits =>
      AppLocalizations.of(this)!.whatIsCardBenefits;

  String get paymentMethods => AppLocalizations.of(this)!.paymentMethods;

  String get fillFamilyInfo => AppLocalizations.of(this)!.fillFamilyInfo;

  String get fullName => AppLocalizations.of(this)!.fullName;

  String get continueT => AppLocalizations.of(this)!.continueT;

  String get maritalStatus => AppLocalizations.of(this)!.maritalStatus;

  String get single => AppLocalizations.of(this)!.single;

  String get married => AppLocalizations.of(this)!.married;

  String get familyMembers => AppLocalizations.of(this)!.familyMembers;

  String get fatherName => AppLocalizations.of(this)!.fatherName;

  String get enterFatherName => AppLocalizations.of(this)!.enterFatherName;

  String get motherName => AppLocalizations.of(this)!.motherName;

  String get enterMotherName => AppLocalizations.of(this)!.enterMotherName;

  String get brotherOrSisterName =>
      AppLocalizations.of(this)!.brotherOrSisterName;

  String get enterBrotherOrSisterName =>
      AppLocalizations.of(this)!.enterBrotherOrSisterName;

  String get enterMoreBrotherOrSisterName =>
      AppLocalizations.of(this)!.enterMoreBrotherOrSisterName;

  String get husbandOrWifeName => AppLocalizations.of(this)!.husbandOrWifeName;

  String get enterHusbandOrWifeName =>
      AppLocalizations.of(this)!.enterHusbandOrWifeName;

  String get sonOrDaughterName => AppLocalizations.of(this)!.sonOrDaughterName;

  String get enterSonOrDaughterName =>
      AppLocalizations.of(this)!.enterSonOrDaughterName;

  String get enterMoreSonOrDaughterName =>
      AppLocalizations.of(this)!.enterMoreSonOrDaughterName;

  String get enterFatherOrMotherName =>
      AppLocalizations.of(this)!.enterFatherOrMotherName;

  String get addPhoto => AppLocalizations.of(this)!.addPhoto;

  String get payment => AppLocalizations.of(this)!.payment;

  String get addPaymentMethod => AppLocalizations.of(this)!.addPaymentMethod;

  String get subscribeUsingCreditCardOrVisa =>
      AppLocalizations.of(this)!.subscribeUsingCreditCardOrVisa;

  String get creditCard => AppLocalizations.of(this)!.creditCard;

  String get addCreditCard => AppLocalizations.of(this)!.addCreditCard;

  String get paymentCard => AppLocalizations.of(this)!.paymentCard;

  String get saveCard => AppLocalizations.of(this)!.saveCard;

  String get addTheCard => AppLocalizations.of(this)!.addTheCard;

  String get confirmPayment => AppLocalizations.of(this)!.confirmPayment;

  String get addNewCard => AppLocalizations.of(this)!.addNewCard;

  String get visa => AppLocalizations.of(this)!.visa;

  String get cash => AppLocalizations.of(this)!.cash;

  String get eWallets => AppLocalizations.of(this)!.eWallets;

  String get noAddress => AppLocalizations.of(this)!.noAddress;

  String get add => AppLocalizations.of(this)!.add;

  String get modify => AppLocalizations.of(this)!.modify;

  String get receiptDetails => AppLocalizations.of(this)!.receiptDetails;

  String get subscriptionType => AppLocalizations.of(this)!.subscriptionType;

  String get deliveryCost => AppLocalizations.of(this)!.deliveryCost;

  String get subscriptionCost => AppLocalizations.of(this)!.subscriptionCost;

  String get receiptTotal => AppLocalizations.of(this)!.receiptTotal;

  String get visaNum => AppLocalizations.of(this)!.visaNum;

  String get visaOwner => AppLocalizations.of(this)!.visaOwner;

  String get visaExpiryDate => AppLocalizations.of(this)!.visaExpiryDate;

  String get cvv => AppLocalizations.of(this)!.cvv;

  String get congratsOnSubSuccess =>
      AppLocalizations.of(this)!.congratsOnSubSuccess;

  String get cardIsDeliveredAfterAWeek =>
      AppLocalizations.of(this)!.cardIsDeliveredAfterAWeek;

  String get cardBenefits => AppLocalizations.of(this)!.cardBenefits;

  String get subStartDate => AppLocalizations.of(this)!.subStartDate;

  String get subEndDate => AppLocalizations.of(this)!.subEndDate;

  String get showRequestState => AppLocalizations.of(this)!.showRequestState;

  String get backHome => AppLocalizations.of(this)!.backHome;

  String get requestDetails => AppLocalizations.of(this)!.requestDetails;

  String get requestCode => AppLocalizations.of(this)!.requestCode;

  String get revisionStep => AppLocalizations.of(this)!.revisionStep;

  String get revisionProcessing =>
      AppLocalizations.of(this)!.revisionProcessing;

  String get revisionDone => AppLocalizations.of(this)!.revisionDone;

  String get shippingStep => AppLocalizations.of(this)!.shippingStep;

  String get yourRequestIsBeingPacked =>
      AppLocalizations.of(this)!.yourRequestIsBeingPacked;

  String get deliveryStep => AppLocalizations.of(this)!.deliveryStep;

  String get yourRequestIsBeingDelivered =>
      AppLocalizations.of(this)!.yourRequestIsBeingDelivered;

  String get underProcessing => AppLocalizations.of(this)!.underProcessing;

  String get communicateWithCustomerService =>
      AppLocalizations.of(this)!.communicateWithCustomerService;

  String get myBalance => AppLocalizations.of(this)!.myBalance;

  String get points => AppLocalizations.of(this)!.points;

  String point(String points) => AppLocalizations.of(this)!.point(points);

  String validityPeriod(String period) =>
      AppLocalizations.of(this)!.validityPeriod(period);

  String get howToGetPoints => AppLocalizations.of(this)!.howToGetPoints;

  String get getPointsWhenScanQR =>
      AppLocalizations.of(this)!.getPointsWhenScanQR;

  String get transactions => AppLocalizations.of(this)!.transactions;

  String get clinicCheck => AppLocalizations.of(this)!.clinicCheck;

  String get outOfDate => AppLocalizations.of(this)!.outOfDate;

  String get earned => AppLocalizations.of(this)!.earned;

  String get totalPoints => AppLocalizations.of(this)!.totalPoints;

  String get usePoints => AppLocalizations.of(this)!.usePoints;

  String get partners => AppLocalizations.of(this)!.partners;

  String get youCanUsePointsWithPartners =>
      AppLocalizations.of(this)!.youCanUsePointsWithPartners;

  String get usable => AppLocalizations.of(this)!.usable;

  String get customersRate => AppLocalizations.of(this)!.customersRate;

  String get rating => AppLocalizations.of(this)!.rating;

  String get addRate => AppLocalizations.of(this)!.addRate;

  String get addYourRate => AppLocalizations.of(this)!.addYourRate;

  String get addComment => AppLocalizations.of(this)!.addComment;

  String get send => AppLocalizations.of(this)!.send;

  String get pharmacy => AppLocalizations.of(this)!.pharmacy;

  String get yourHealthCare => AppLocalizations.of(this)!.yourHealthCare;

  String get askForMedicine => AppLocalizations.of(this)!.askForMedicine;

  String get requestNow => AppLocalizations.of(this)!.requestNow;

  String get askNow => AppLocalizations.of(this)!.askNow;

  String get askDocSub => AppLocalizations.of(this)!.askDocSub;

  String get askForAmbulance => AppLocalizations.of(this)!.askForAmbulance;

  String get pharmacySub => AppLocalizations.of(this)!.pharmacySub;

  String get allMedicineIsSoldThroughLicensedPharmacies =>
      AppLocalizations.of(this)!.allMedicineIsSoldThroughLicensedPharmacies;

  String get freePharmacyDelivery => AppLocalizations.of(this)!.freePharmacyDelivery;
  String get freeDiscountOnRequest => AppLocalizations.of(this)!.freeDiscountOnRequest;

  String get goToWhatsUp => AppLocalizations.of(this)!.goToWhatsUp;

  String get askDoctor => AppLocalizations.of(this)!.askDoctor;

  String get talkToDoctor => AppLocalizations.of(this)!.talkToDoctor;

  String get homeNursing => AppLocalizations.of(this)!.homeNursing;

  String get askForHomeNursing => AppLocalizations.of(this)!.askForHomeNursing;

  String get homeCare => AppLocalizations.of(this)!.homeCare;

  String get askForHomeCare => AppLocalizations.of(this)!.askForHomeCare;

  String get homeCareTypes => AppLocalizations.of(this)!.homeCareTypes;

  String get medicalRecord => AppLocalizations.of(this)!.medicalRecord;

  String get xrayDetails => AppLocalizations.of(this)!.xrayDetails;

  String get xrayName => AppLocalizations.of(this)!.xrayName;

  String get addAnotherName => AppLocalizations.of(this)!.addAnotherName;

  String get xrayCenterName => AppLocalizations.of(this)!.xrayCenterName;

  String get addTheXRay => AppLocalizations.of(this)!.addTheXRay;

  String get asPhoto => AppLocalizations.of(this)!.asPhoto;

  String get asPDF => AppLocalizations.of(this)!.asPDF;

  String get image => AppLocalizations.of(this)!.image;

  String get pdf => AppLocalizations.of(this)!.pdf;

  String delete(String value) => AppLocalizations.of(this)!.delete(value);

  String areYouSureToDelete(String value) =>
      AppLocalizations.of(this)!.areYouSureToDelete(value);

  String get clinics => AppLocalizations.of(this)!.clinics;

  String get specializations => AppLocalizations.of(this)!.specializations;

  String get chooseRegion => AppLocalizations.of(this)!.chooseRegion;

  String get chooseCity => AppLocalizations.of(this)!.chooseCity;

  String get searchingIn => AppLocalizations.of(this)!.searchingIn;

  String get highestRate => AppLocalizations.of(this)!.highestRate;

  String get onlinePayment => AppLocalizations.of(this)!.onlinePayment;

  String get highestDiscount => AppLocalizations.of(this)!.highestDiscount;

  String get nearToMe => AppLocalizations.of(this)!.nearToMe;

  String get bestDiscount => AppLocalizations.of(this)!.bestDiscount;

  String get notifications => AppLocalizations.of(this)!.notifications;

  String get doctor => AppLocalizations.of(this)!.doctor;

  String get service => AppLocalizations.of(this)!.service;

  String get freeDiscount => AppLocalizations.of(this)!.freeDiscount;

  String get insuranceCardDiscount =>
      AppLocalizations.of(this)!.insuranceCardDiscount;

  String getFreeDiscount(String discount) =>
      AppLocalizations.of(this)!.getFreeDiscount(discount);

  String getInsuranceCardDiscount(String discount) =>
      AppLocalizations.of(this)!.getInsuranceCardDiscount(discount);

  String about(String service) => AppLocalizations.of(this)!.about(service);

  String get workHours => AppLocalizations.of(this)!.workHours;

  String get bookingAvailability =>
      AppLocalizations.of(this)!.bookingAvailability;

  String get availableNow => AppLocalizations.of(this)!.availableNow;

  String get addresses => AppLocalizations.of(this)!.addresses;

  String get customersRating => AppLocalizations.of(this)!.customersRating;

  String get phone => AppLocalizations.of(this)!.phone;

  String get edit => AppLocalizations.of(this)!.edit;

  String pound(String value) => AppLocalizations.of(this)!.pound(value);

  String get fatherOrMotherName =>
      AppLocalizations.of(this)!.fatherOrMotherName;

  String get locationTitle => AppLocalizations.of(this)!.locationTitle;
}
