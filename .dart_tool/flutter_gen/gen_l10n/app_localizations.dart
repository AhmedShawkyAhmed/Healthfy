import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar')
  ];

  /// No description provided for @healthify.
  ///
  /// In ar, this message translates to:
  /// **'صحتك تهمنا'**
  String get healthify;

  /// No description provided for @onBoarding1Text1.
  ///
  /// In ar, this message translates to:
  /// **'الاقرب اليك'**
  String get onBoarding1Text1;

  /// No description provided for @onBoarding1Text2.
  ///
  /// In ar, this message translates to:
  /// **'سهولة الوصول الي مختلف انواع المؤسسات الطبية ( مستشفيات - عيادات - صيدليات - مراكز اشعة - معامل تحاليل )'**
  String get onBoarding1Text2;

  /// No description provided for @onBoarding2Text1.
  ///
  /// In ar, this message translates to:
  /// **'مكافآت'**
  String get onBoarding2Text1;

  /// No description provided for @onBoarding2Text2.
  ///
  /// In ar, this message translates to:
  /// **'احصل علي نقط مكافئة علي كل معاملاتك واستبدالها بخصومات علي انواع محددة من الخدمات.'**
  String get onBoarding2Text2;

  /// No description provided for @onBoarding3Text1.
  ///
  /// In ar, this message translates to:
  /// **'خصومات '**
  String get onBoarding3Text1;

  /// No description provided for @onBoarding3Text2.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك الاستمتع بخصومات حين تواجدك بالمؤسسة الطبيةالمتعاقدة معنا عن طريق مسح Qr code و الاستفادة بالخصم'**
  String get onBoarding3Text2;

  /// No description provided for @onBoarding4Text1.
  ///
  /// In ar, this message translates to:
  /// **'بطاقة التأمين السنوي'**
  String get onBoarding4Text1;

  /// No description provided for @onBoarding4Text2.
  ///
  /// In ar, this message translates to:
  /// **'يوفر لك كارت التأمين السنوي خصومات تصل الي 60% مع كل المؤسسات الطبية المتعاقدة معنا '**
  String get onBoarding4Text2;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'ادخل رقم الهاتف'**
  String get phoneNumber;

  /// No description provided for @privacy1.
  ///
  /// In ar, this message translates to:
  /// **'استخدامك لهاذا التطبيق يعني موافقتك علي'**
  String get privacy1;

  /// No description provided for @privacy2.
  ///
  /// In ar, this message translates to:
  /// **'سياسة وشروط الأستخدام'**
  String get privacy2;

  /// No description provided for @follow.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get follow;

  /// No description provided for @enterCode.
  ///
  /// In ar, this message translates to:
  /// **' ادخل رمز التحقق المكون من 6 ارقام'**
  String get enterCode;

  /// No description provided for @code.
  ///
  /// In ar, this message translates to:
  /// **'رمز التحقق'**
  String get code;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @areYouReceived.
  ///
  /// In ar, this message translates to:
  /// **' هل حصلت علي رمز التحقق؟'**
  String get areYouReceived;

  /// No description provided for @resend.
  ///
  /// In ar, this message translates to:
  /// **' اعادة ارسال'**
  String get resend;

  /// No description provided for @happy.
  ///
  /// In ar, this message translates to:
  /// **'سعيدون بلقائك!'**
  String get happy;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @phoneCodeSelect.
  ///
  /// In ar, this message translates to:
  /// **'اختر رمز الهاتف'**
  String get phoneCodeSelect;

  /// No description provided for @gallery.
  ///
  /// In ar, this message translates to:
  /// **'المعرض'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In ar, this message translates to:
  /// **'الكاميرا'**
  String get camera;

  /// No description provided for @account.
  ///
  /// In ar, this message translates to:
  /// **'الحساب'**
  String get account;

  /// No description provided for @myAccount.
  ///
  /// In ar, this message translates to:
  /// **'حسابى'**
  String get myAccount;

  /// No description provided for @rewards.
  ///
  /// In ar, this message translates to:
  /// **'المكافآت'**
  String get rewards;

  /// No description provided for @pointNumber.
  ///
  /// In ar, this message translates to:
  /// **'{number} نقطة'**
  String pointNumber(num number);

  /// No description provided for @myAddress.
  ///
  /// In ar, this message translates to:
  /// **'عنواني'**
  String get myAddress;

  /// No description provided for @favourite.
  ///
  /// In ar, this message translates to:
  /// **'المفضلة'**
  String get favourite;

  /// No description provided for @helpTitle.
  ///
  /// In ar, this message translates to:
  /// **'المساعدة و الدعم'**
  String get helpTitle;

  /// No description provided for @help.
  ///
  /// In ar, this message translates to:
  /// **'الدعم'**
  String get help;

  /// No description provided for @aboutApp.
  ///
  /// In ar, this message translates to:
  /// **'من نحن'**
  String get aboutApp;

  /// No description provided for @terms.
  ///
  /// In ar, this message translates to:
  /// **'الشروط و الاحكام'**
  String get terms;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @accountSettings.
  ///
  /// In ar, this message translates to:
  /// **'اعدادات الحساب'**
  String get accountSettings;

  /// No description provided for @updateImage.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الصورة'**
  String get updateImage;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'ادخل رقم الهاتف'**
  String get enterPhoneNumber;

  /// No description provided for @name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get name;

  /// No description provided for @emailAddress.
  ///
  /// In ar, this message translates to:
  /// **'البريد الالكترونى'**
  String get emailAddress;

  /// No description provided for @birthdate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الميلاد'**
  String get birthdate;

  /// No description provided for @saveChanges.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التغيرات'**
  String get saveChanges;

  /// No description provided for @deliveryLocations.
  ///
  /// In ar, this message translates to:
  /// **'عناوين التوصيل'**
  String get deliveryLocations;

  /// No description provided for @deliveryLocationDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل عنوان التوصيل'**
  String get deliveryLocationDetails;

  /// No description provided for @addNewLocation.
  ///
  /// In ar, this message translates to:
  /// **'اضف عنوان جديد'**
  String get addNewLocation;

  /// No description provided for @emptyLocations.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عناوين محفوظة'**
  String get emptyLocations;

  /// No description provided for @selectYourLocation.
  ///
  /// In ar, this message translates to:
  /// **'حدد موقعك'**
  String get selectYourLocation;

  /// No description provided for @confirmLocation.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الموقع'**
  String get confirmLocation;

  /// No description provided for @saveLocation.
  ///
  /// In ar, this message translates to:
  /// **'حفظ المكان لاستخدامة لاحقاً'**
  String get saveLocation;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @city.
  ///
  /// In ar, this message translates to:
  /// **'المحافظة'**
  String get city;

  /// No description provided for @area.
  ///
  /// In ar, this message translates to:
  /// **'المنطقة'**
  String get area;

  /// No description provided for @streetName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الشارع'**
  String get streetName;

  /// No description provided for @buildingNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم العمارة'**
  String get buildingNumber;

  /// No description provided for @floorNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الدور'**
  String get floorNumber;

  /// No description provided for @flatNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الشقة'**
  String get flatNumber;

  /// No description provided for @additionalInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومة اضافية'**
  String get additionalInfo;

  /// No description provided for @scanCode.
  ///
  /// In ar, this message translates to:
  /// **'مسح الرمز'**
  String get scanCode;

  /// No description provided for @discount.
  ///
  /// In ar, this message translates to:
  /// **'الخصم'**
  String get discount;

  /// No description provided for @cancelBooking.
  ///
  /// In ar, this message translates to:
  /// **'الغاء الحجز'**
  String get cancelBooking;

  /// No description provided for @cancelService.
  ///
  /// In ar, this message translates to:
  /// **'الغاء الخدمة'**
  String get cancelService;

  /// No description provided for @cancelServiceTime.
  ///
  /// In ar, this message translates to:
  /// **'يمكن الغاء الخدمة بعد ساعتين'**
  String get cancelServiceTime;

  /// No description provided for @confirmBooking.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الحجز'**
  String get confirmBooking;

  /// No description provided for @choosePayment.
  ///
  /// In ar, this message translates to:
  /// **'اختر طريقة الدفع'**
  String get choosePayment;

  /// No description provided for @serviceCost.
  ///
  /// In ar, this message translates to:
  /// **'تكلفة الخدمة'**
  String get serviceCost;

  /// No description provided for @serviceCostHint.
  ///
  /// In ar, this message translates to:
  /// **'ادخل تكلفة الخدمة'**
  String get serviceCostHint;

  /// No description provided for @costAfterDiscount.
  ///
  /// In ar, this message translates to:
  /// **'التكلفة بعد الخصم'**
  String get costAfterDiscount;

  /// No description provided for @disclosurePrice.
  ///
  /// In ar, this message translates to:
  /// **'ثمن الكشف'**
  String get disclosurePrice;

  /// No description provided for @disclosurePriceHint.
  ///
  /// In ar, this message translates to:
  /// **'ادخل ثمن الكشف'**
  String get disclosurePriceHint;

  /// No description provided for @hour.
  ///
  /// In ar, this message translates to:
  /// **'الساعة'**
  String get hour;

  /// No description provided for @hourHint.
  ///
  /// In ar, this message translates to:
  /// **'ادخل الوقت'**
  String get hourHint;

  /// No description provided for @date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get date;

  /// No description provided for @dateHint.
  ///
  /// In ar, this message translates to:
  /// **'ادخل التاريخ'**
  String get dateHint;

  /// No description provided for @servicesHint.
  ///
  /// In ar, this message translates to:
  /// **'اختر الخدمة'**
  String get servicesHint;

  /// No description provided for @addressHint.
  ///
  /// In ar, this message translates to:
  /// **'ادخل العنوان'**
  String get addressHint;

  /// No description provided for @organizationName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المؤسسة الطبية'**
  String get organizationName;

  /// No description provided for @organizationNameHint.
  ///
  /// In ar, this message translates to:
  /// **'ادخل اسم الطبيب او المؤسسة الطبية'**
  String get organizationNameHint;

  /// No description provided for @customerPhone.
  ///
  /// In ar, this message translates to:
  /// **'رقم العميل'**
  String get customerPhone;

  /// No description provided for @customerPhoneHint.
  ///
  /// In ar, this message translates to:
  /// **'ادخل رقم الهاتف'**
  String get customerPhoneHint;

  /// No description provided for @customerName.
  ///
  /// In ar, this message translates to:
  /// **'اسم العميل'**
  String get customerName;

  /// No description provided for @customerNameHint.
  ///
  /// In ar, this message translates to:
  /// **'ادخل اسم العميل'**
  String get customerNameHint;

  /// No description provided for @discountAcquired.
  ///
  /// In ar, this message translates to:
  /// **'تم الحصول علي خصم {val}%'**
  String discountAcquired(num val);

  /// No description provided for @bookingSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم الحجز بنجاح'**
  String get bookingSuccess;

  /// No description provided for @congrats.
  ///
  /// In ar, this message translates to:
  /// **'تهانينا'**
  String get congrats;

  /// No description provided for @chooseSubscription.
  ///
  /// In ar, this message translates to:
  /// **'اختر خطة الاشتراك'**
  String get chooseSubscription;

  /// No description provided for @andGetDiscount.
  ///
  /// In ar, this message translates to:
  /// **'و استمتع بخصومات حصرية'**
  String get andGetDiscount;

  /// No description provided for @individualInsurance.
  ///
  /// In ar, this message translates to:
  /// **'التأمين الفردي'**
  String get individualInsurance;

  /// No description provided for @familyInsurance.
  ///
  /// In ar, this message translates to:
  /// **'التأمين العائلي'**
  String get familyInsurance;

  /// No description provided for @subscribeNow.
  ///
  /// In ar, this message translates to:
  /// **'اشترك الان'**
  String get subscribeNow;

  /// No description provided for @commonQuestions.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة'**
  String get commonQuestions;

  /// No description provided for @whatIsCardBenefits.
  ///
  /// In ar, this message translates to:
  /// **'ما هي مميزات كارت التـامين السنوي'**
  String get whatIsCardBenefits;

  /// No description provided for @paymentMethods.
  ///
  /// In ar, this message translates to:
  /// **'طرق الدفع'**
  String get paymentMethods;

  /// No description provided for @fillFamilyInfo.
  ///
  /// In ar, this message translates to:
  /// **'ملئ بيانات الاشتراك العائلي'**
  String get fillFamilyInfo;

  /// No description provided for @fullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم كامل '**
  String get fullName;

  /// No description provided for @continueT.
  ///
  /// In ar, this message translates to:
  /// **'استمر '**
  String get continueT;

  /// No description provided for @maritalStatus.
  ///
  /// In ar, this message translates to:
  /// **'الحالة الاجتماعية '**
  String get maritalStatus;

  /// No description provided for @single.
  ///
  /// In ar, this message translates to:
  /// **'اعزب '**
  String get single;

  /// No description provided for @married.
  ///
  /// In ar, this message translates to:
  /// **'متزوج/متزوجة '**
  String get married;

  /// No description provided for @familyMembers.
  ///
  /// In ar, this message translates to:
  /// **'افراد عائلتي'**
  String get familyMembers;

  /// No description provided for @fatherName.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الأب'**
  String get fatherName;

  /// No description provided for @enterFatherName.
  ///
  /// In ar, this message translates to:
  /// **'ادخل اسم الأب '**
  String get enterFatherName;

  /// No description provided for @motherName.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الأم'**
  String get motherName;

  /// No description provided for @enterMotherName.
  ///
  /// In ar, this message translates to:
  /// **'ادخل اسم الام '**
  String get enterMotherName;

  /// No description provided for @brotherOrSisterName.
  ///
  /// In ar, this message translates to:
  /// **'معلومات (الأخ/الأخت) '**
  String get brotherOrSisterName;

  /// No description provided for @enterBrotherOrSisterName.
  ///
  /// In ar, this message translates to:
  /// **'ادخل اسم (الأخ/الأخت) '**
  String get enterBrotherOrSisterName;

  /// No description provided for @enterMoreBrotherOrSisterName.
  ///
  /// In ar, this message translates to:
  /// **'اضافة معلومات (الأخ/الأخت) اخر '**
  String get enterMoreBrotherOrSisterName;

  /// No description provided for @husbandOrWifeName.
  ///
  /// In ar, this message translates to:
  /// **'معلومات (الزوجة/ الزوج) '**
  String get husbandOrWifeName;

  /// No description provided for @enterHusbandOrWifeName.
  ///
  /// In ar, this message translates to:
  /// **' ادخل اسم (الزوجة/ الزوج) '**
  String get enterHusbandOrWifeName;

  /// No description provided for @sonOrDaughterName.
  ///
  /// In ar, this message translates to:
  /// **'معلومات (الإبن / الإبنة) '**
  String get sonOrDaughterName;

  /// No description provided for @enterSonOrDaughterName.
  ///
  /// In ar, this message translates to:
  /// **'ادخل معلومات (الإبن / الإبنة) '**
  String get enterSonOrDaughterName;

  /// No description provided for @enterMoreSonOrDaughterName.
  ///
  /// In ar, this message translates to:
  /// **'اضافة معلومات (إبن / إبنة) اخر '**
  String get enterMoreSonOrDaughterName;

  /// No description provided for @enterFatherOrMotherName.
  ///
  /// In ar, this message translates to:
  /// **'اضافة معلومات (الأب / الام)  '**
  String get enterFatherOrMotherName;

  /// No description provided for @addPhoto.
  ///
  /// In ar, this message translates to:
  /// **'اضافة صور'**
  String get addPhoto;

  /// No description provided for @payment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع'**
  String get payment;

  /// No description provided for @addPaymentMethod.
  ///
  /// In ar, this message translates to:
  /// **'اضافة طريقة الدفع'**
  String get addPaymentMethod;

  /// No description provided for @subscribeUsingCreditCardOrVisa.
  ///
  /// In ar, this message translates to:
  /// **'للاشتراك يمكنك استخدام بطاقة ائتمان / فيزا.'**
  String get subscribeUsingCreditCardOrVisa;

  /// No description provided for @creditCard.
  ///
  /// In ar, this message translates to:
  /// **'بطاقات الائتمان'**
  String get creditCard;

  /// No description provided for @addCreditCard.
  ///
  /// In ar, this message translates to:
  /// **'اضف بطاقة ائتمان'**
  String get addCreditCard;

  /// No description provided for @paymentCard.
  ///
  /// In ar, this message translates to:
  /// **'كارت الدفع'**
  String get paymentCard;

  /// No description provided for @saveCard.
  ///
  /// In ar, this message translates to:
  /// **'احفظ الكارت'**
  String get saveCard;

  /// No description provided for @addTheCard.
  ///
  /// In ar, this message translates to:
  /// **'اضف البطاقة'**
  String get addTheCard;

  /// No description provided for @confirmPayment.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الدفع'**
  String get confirmPayment;

  /// No description provided for @addNewCard.
  ///
  /// In ar, this message translates to:
  /// **'اضافة بطاقة جديدة'**
  String get addNewCard;

  /// No description provided for @eWallets.
  ///
  /// In ar, this message translates to:
  /// **'المحافظ الإكترونية (E-Wallet).'**
  String get eWallets;

  /// No description provided for @visa.
  ///
  /// In ar, this message translates to:
  /// **'فيزا'**
  String get visa;

  /// No description provided for @cash.
  ///
  /// In ar, this message translates to:
  /// **'الدفع نقداً.'**
  String get cash;

  /// No description provided for @address.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get address;

  /// No description provided for @noAddress.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد عنوان'**
  String get noAddress;

  /// No description provided for @add.
  ///
  /// In ar, this message translates to:
  /// **'اضافة'**
  String get add;

  /// No description provided for @modify.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get modify;

  /// No description provided for @receiptDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الفاتورة'**
  String get receiptDetails;

  /// No description provided for @subscriptionType.
  ///
  /// In ar, this message translates to:
  /// **'نوع الاشتراك'**
  String get subscriptionType;

  /// No description provided for @deliveryCost.
  ///
  /// In ar, this message translates to:
  /// **'تكلفة التوصيل'**
  String get deliveryCost;

  /// No description provided for @subscriptionCost.
  ///
  /// In ar, this message translates to:
  /// **'تكلفة الاشتراك'**
  String get subscriptionCost;

  /// No description provided for @receiptTotal.
  ///
  /// In ar, this message translates to:
  /// **'اجمالي الفاتورة'**
  String get receiptTotal;

  /// No description provided for @visaNum.
  ///
  /// In ar, this message translates to:
  /// **'رقم الفيزا'**
  String get visaNum;

  /// No description provided for @visaOwner.
  ///
  /// In ar, this message translates to:
  /// **'اسم مالك الفيزا'**
  String get visaOwner;

  /// No description provided for @visaExpiryDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الانتهاء'**
  String get visaExpiryDate;

  /// No description provided for @cvv.
  ///
  /// In ar, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @congratsOnSubSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تهانيا تم الاشتراك بنجاح'**
  String get congratsOnSubSuccess;

  /// No description provided for @cardIsDeliveredAfterAWeek.
  ///
  /// In ar, this message translates to:
  /// **'يتم استلام الكارت بعد اسبوع من تاريخ الاشتراك'**
  String get cardIsDeliveredAfterAWeek;

  /// No description provided for @cardBenefits.
  ///
  /// In ar, this message translates to:
  /// **'مميزات الاشتراك في كارت التأمين'**
  String get cardBenefits;

  /// No description provided for @subStartDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الاشتراك'**
  String get subStartDate;

  /// No description provided for @subEndDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ نهاية الاشتراك'**
  String get subEndDate;

  /// No description provided for @showRequestState.
  ///
  /// In ar, this message translates to:
  /// **'تتبع حالة الطلب'**
  String get showRequestState;

  /// No description provided for @backHome.
  ///
  /// In ar, this message translates to:
  /// **'الرجوع للصفحة الرئيسية'**
  String get backHome;

  /// No description provided for @requestDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الطلب'**
  String get requestDetails;

  /// No description provided for @requestCode.
  ///
  /// In ar, this message translates to:
  /// **'كود الطلب'**
  String get requestCode;

  /// No description provided for @revisionStep.
  ///
  /// In ar, this message translates to:
  /// **'مرحلة المراجعة'**
  String get revisionStep;

  /// No description provided for @revisionProcessing.
  ///
  /// In ar, this message translates to:
  /// **'جاري مراجعة طلبك'**
  String get revisionProcessing;

  /// No description provided for @revisionDone.
  ///
  /// In ar, this message translates to:
  /// **'تم مراجعة طلبك'**
  String get revisionDone;

  /// No description provided for @shippingStep.
  ///
  /// In ar, this message translates to:
  /// **'مرحلة الشحن'**
  String get shippingStep;

  /// No description provided for @yourRequestIsBeingPacked.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحضير طلبك'**
  String get yourRequestIsBeingPacked;

  /// No description provided for @deliveryStep.
  ///
  /// In ar, this message translates to:
  /// **'مرحلة التوصيل'**
  String get deliveryStep;

  /// No description provided for @yourRequestIsBeingDelivered.
  ///
  /// In ar, this message translates to:
  /// **'جاري توصيل طلبك'**
  String get yourRequestIsBeingDelivered;

  /// No description provided for @underProcessing.
  ///
  /// In ar, this message translates to:
  /// **'قيد التنفيذ'**
  String get underProcessing;

  /// No description provided for @communicateWithCustomerService.
  ///
  /// In ar, this message translates to:
  /// **'تواصل مع الدعم'**
  String get communicateWithCustomerService;

  /// No description provided for @myBalance.
  ///
  /// In ar, this message translates to:
  /// **'رصيدي'**
  String get myBalance;

  /// No description provided for @points.
  ///
  /// In ar, this message translates to:
  /// **'النقاط'**
  String get points;

  /// No description provided for @point.
  ///
  /// In ar, this message translates to:
  /// **'{points} نقطة'**
  String point(Object points);

  /// No description provided for @validityPeriod.
  ///
  /// In ar, this message translates to:
  /// **'مدة صلاحية النقاط {period} فقط'**
  String validityPeriod(Object period);

  /// No description provided for @howToGetPoints.
  ///
  /// In ar, this message translates to:
  /// **'كيفية الحصول علي  النقاط '**
  String get howToGetPoints;

  /// No description provided for @getPointsWhenScanQR.
  ///
  /// In ar, this message translates to:
  /// **' الحصول علي النقاط عن طريق مسح Qr code\n عند  عملية الحجز.'**
  String get getPointsWhenScanQR;

  /// No description provided for @transactions.
  ///
  /// In ar, this message translates to:
  /// **'المعاملات'**
  String get transactions;

  /// No description provided for @clinicCheck.
  ///
  /// In ar, this message translates to:
  /// **'كشف في العيادة'**
  String get clinicCheck;

  /// No description provided for @outOfDate.
  ///
  /// In ar, this message translates to:
  /// **'منتهية الصلاحية'**
  String get outOfDate;

  /// No description provided for @earned.
  ///
  /// In ar, this message translates to:
  /// **'مستحقة'**
  String get earned;

  /// No description provided for @totalPoints.
  ///
  /// In ar, this message translates to:
  /// **'اجمالي النقاط'**
  String get totalPoints;

  /// No description provided for @usePoints.
  ///
  /// In ar, this message translates to:
  /// **'استخدام النقاط'**
  String get usePoints;

  /// No description provided for @partners.
  ///
  /// In ar, this message translates to:
  /// **'الشركاء'**
  String get partners;

  /// No description provided for @youCanUsePointsWithPartners.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك الاستفادة من النقاط من خلال شراكائنا'**
  String get youCanUsePointsWithPartners;

  /// No description provided for @usable.
  ///
  /// In ar, this message translates to:
  /// **'صالحة للإستخدام'**
  String get usable;

  /// No description provided for @customersRate.
  ///
  /// In ar, this message translates to:
  /// **'تقييمات العملاء'**
  String get customersRate;

  /// No description provided for @rating.
  ///
  /// In ar, this message translates to:
  /// **'التقييم'**
  String get rating;

  /// No description provided for @addRate.
  ///
  /// In ar, this message translates to:
  /// **'اضافة تقييم'**
  String get addRate;

  /// No description provided for @addYourRate.
  ///
  /// In ar, this message translates to:
  /// **'قم بتقييم الخدمة'**
  String get addYourRate;

  /// No description provided for @addComment.
  ///
  /// In ar, this message translates to:
  /// **'اكتب تعليق..'**
  String get addComment;

  /// No description provided for @send.
  ///
  /// In ar, this message translates to:
  /// **'ارسال'**
  String get send;

  /// No description provided for @pharmacy.
  ///
  /// In ar, this message translates to:
  /// **'صيدلية'**
  String get pharmacy;

  /// No description provided for @yourHealthCare.
  ///
  /// In ar, this message translates to:
  /// **' صحتك تهمنا'**
  String get yourHealthCare;

  /// No description provided for @askForMedicine.
  ///
  /// In ar, this message translates to:
  /// **'اطلب ادويتك'**
  String get askForMedicine;

  /// No description provided for @pharmacySub.
  ///
  /// In ar, this message translates to:
  /// **'و كل ما تحتاجه من الصيدلية'**
  String get pharmacySub;

  /// No description provided for @askDocSub.
  ///
  /// In ar, this message translates to:
  /// **'ارسل سؤالك الطبى و احصل على إجابة من دكتور متخصص'**
  String get askDocSub;

  /// No description provided for @askNow.
  ///
  /// In ar, this message translates to:
  /// **'اسأل الان'**
  String get askNow;

  /// No description provided for @requestNow.
  ///
  /// In ar, this message translates to:
  /// **'اطلب الان'**
  String get requestNow;

  /// No description provided for @allMedicineIsSoldThroughLicensedPharmacies.
  ///
  /// In ar, this message translates to:
  /// **'جميع الأدوية يتم صرفها من صيدليات مرخصة من\nوزارة الصحة و بوجود وصفة طبية من طبيب مختص. '**
  String get allMedicineIsSoldThroughLicensedPharmacies;

  /// No description provided for @freePharmacyDelivery.
  ///
  /// In ar, this message translates to:
  /// **'خصم مجانى + خدمة التوصيل مجانا'**
  String get freePharmacyDelivery;

  /// No description provided for @freeDiscountOnRequest.
  ///
  /// In ar, this message translates to:
  /// **'اطلب الخدمه و احصل على خصمك المجانى'**
  String get freeDiscountOnRequest;

  /// No description provided for @goToWhatsUp.
  ///
  /// In ar, this message translates to:
  /// **'الانتقال الي واتساب '**
  String get goToWhatsUp;

  /// No description provided for @askDoctor.
  ///
  /// In ar, this message translates to:
  /// **'اسأل دكتور'**
  String get askDoctor;

  /// No description provided for @talkToDoctor.
  ///
  /// In ar, this message translates to:
  /// **'لديك سؤال طبى ؟'**
  String get talkToDoctor;

  /// No description provided for @askForAmbulance.
  ///
  /// In ar, this message translates to:
  /// **'اطلب سيارة اسعاف'**
  String get askForAmbulance;

  /// No description provided for @homeNursing.
  ///
  /// In ar, this message translates to:
  /// **' التمريض المنزلي'**
  String get homeNursing;

  /// No description provided for @askForHomeNursing.
  ///
  /// In ar, this message translates to:
  /// **'احصل على افضل خدمة تمريض'**
  String get askForHomeNursing;

  /// No description provided for @homeCare.
  ///
  /// In ar, this message translates to:
  /// **'الرعاية المنزلية'**
  String get homeCare;

  /// No description provided for @homeCareTypes.
  ///
  /// In ar, this message translates to:
  /// **'( كشف منزلى - اشعه منزليه - تحاليل منزليه )'**
  String get homeCareTypes;

  /// No description provided for @askForHomeCare.
  ///
  /// In ar, this message translates to:
  /// **'احصل على خدمات الرعاية المنزلية'**
  String get askForHomeCare;

  /// No description provided for @services.
  ///
  /// In ar, this message translates to:
  /// **'الخدمات '**
  String get services;

  /// No description provided for @medicalRecord.
  ///
  /// In ar, this message translates to:
  /// **'السجل الطبي '**
  String get medicalRecord;

  /// No description provided for @ambulance.
  ///
  /// In ar, this message translates to:
  /// **'الإسعاف'**
  String get ambulance;

  /// No description provided for @xrayDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الأشعة '**
  String get xrayDetails;

  /// No description provided for @xrayName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الاشعة '**
  String get xrayName;

  /// No description provided for @addAnotherName.
  ///
  /// In ar, this message translates to:
  /// **'اضافة اسم اخر '**
  String get addAnotherName;

  /// No description provided for @xrayCenterName.
  ///
  /// In ar, this message translates to:
  /// **'اسم مركز الاشعة '**
  String get xrayCenterName;

  /// No description provided for @addTheXRay.
  ///
  /// In ar, this message translates to:
  /// **'ارفع نتيجة الاشعة  '**
  String get addTheXRay;

  /// No description provided for @asPhoto.
  ///
  /// In ar, this message translates to:
  /// **'(صور)'**
  String get asPhoto;

  /// No description provided for @asPDF.
  ///
  /// In ar, this message translates to:
  /// **'(ملف PDF) '**
  String get asPDF;

  /// No description provided for @image.
  ///
  /// In ar, this message translates to:
  /// **'الصورة '**
  String get image;

  /// No description provided for @pdf.
  ///
  /// In ar, this message translates to:
  /// **'ملف pdf'**
  String get pdf;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف {value} '**
  String delete(Object value);

  /// No description provided for @areYouSureToDelete.
  ///
  /// In ar, this message translates to:
  /// **'هل انت متأكد من حذف {value}\nمن ملفك؟'**
  String areYouSureToDelete(Object value);

  /// No description provided for @back.
  ///
  /// In ar, this message translates to:
  /// **'الرجوع'**
  String get back;

  /// No description provided for @clinics.
  ///
  /// In ar, this message translates to:
  /// **'العيادات'**
  String get clinics;

  /// No description provided for @specializations.
  ///
  /// In ar, this message translates to:
  /// **'التخصصات'**
  String get specializations;

  /// No description provided for @chooseRegion.
  ///
  /// In ar, this message translates to:
  /// **'اختر المنطقة'**
  String get chooseRegion;

  /// No description provided for @chooseCity.
  ///
  /// In ar, this message translates to:
  /// **'اختر المدينة'**
  String get chooseCity;

  /// No description provided for @searchingIn.
  ///
  /// In ar, this message translates to:
  /// **'تبحث في'**
  String get searchingIn;

  /// No description provided for @highestRate.
  ///
  /// In ar, this message translates to:
  /// **'الأعلي تقييم'**
  String get highestRate;

  /// No description provided for @highestDiscount.
  ///
  /// In ar, this message translates to:
  /// **'اعلي خصم'**
  String get highestDiscount;

  /// No description provided for @nearToMe.
  ///
  /// In ar, this message translates to:
  /// **'قريب مني'**
  String get nearToMe;

  /// No description provided for @bestDiscount.
  ///
  /// In ar, this message translates to:
  /// **'أفضل الخصومات'**
  String get bestDiscount;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @doctor.
  ///
  /// In ar, this message translates to:
  /// **'الطبيب'**
  String get doctor;

  /// No description provided for @service.
  ///
  /// In ar, this message translates to:
  /// **'الخدمة'**
  String get service;

  /// No description provided for @freeDiscount.
  ///
  /// In ar, this message translates to:
  /// **'الخصم المجاني'**
  String get freeDiscount;

  /// No description provided for @insuranceCard.
  ///
  /// In ar, this message translates to:
  /// **'كارت التأمين السنوي'**
  String get insuranceCard;

  /// No description provided for @insuranceCardDiscount.
  ///
  /// In ar, this message translates to:
  /// **'خصم كارت التامين '**
  String get insuranceCardDiscount;

  /// No description provided for @getFreeDiscount.
  ///
  /// In ar, this message translates to:
  /// **'احصل علي {discount}% خصم المجاني '**
  String getFreeDiscount(Object discount);

  /// No description provided for @getInsuranceCardDiscount.
  ///
  /// In ar, this message translates to:
  /// **'احصل علي {discount}% خصم من خلال التأمين السنوي'**
  String getInsuranceCardDiscount(Object discount);

  /// No description provided for @about.
  ///
  /// In ar, this message translates to:
  /// **'عن {service}'**
  String about(Object service);

  /// No description provided for @workHours.
  ///
  /// In ar, this message translates to:
  /// **'ساعات العمل'**
  String get workHours;

  /// No description provided for @bookingAvailability.
  ///
  /// In ar, this message translates to:
  /// **'امكانية الحجز'**
  String get bookingAvailability;

  /// No description provided for @availableNow.
  ///
  /// In ar, this message translates to:
  /// **'متاح الآن'**
  String get availableNow;

  /// No description provided for @phone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف'**
  String get phone;

  /// No description provided for @addresses.
  ///
  /// In ar, this message translates to:
  /// **'العناوين'**
  String get addresses;

  /// No description provided for @customersRating.
  ///
  /// In ar, this message translates to:
  /// **'تقييمات العملاء'**
  String get customersRating;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @pound.
  ///
  /// In ar, this message translates to:
  /// **'{value} جنية'**
  String pound(Object value);

  /// No description provided for @fatherOrMotherName.
  ///
  /// In ar, this message translates to:
  /// **'معلومات (الأب / الام)  '**
  String get fatherOrMotherName;

  /// No description provided for @locationTitle.
  ///
  /// In ar, this message translates to:
  /// **'اسم الموقع (مثال: البيت)'**
  String get locationTitle;

  /// No description provided for @myReservation.
  ///
  /// In ar, this message translates to:
  /// **'حجوزاتي'**
  String get myReservation;

  /// No description provided for @installmentFeature.
  ///
  /// In ar, this message translates to:
  /// **'خدمات بالتقسيط'**
  String get installmentFeature;

  /// No description provided for @myLocation.
  ///
  /// In ar, this message translates to:
  /// **'تحديد موقعك'**
  String get myLocation;

  /// No description provided for @onlinePayment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع الالكترونى'**
  String get onlinePayment;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'{val} إلغاء'**
  String cancel(String val);

  /// No description provided for @deleteAccountConfirmationDialog.
  ///
  /// In ar, this message translates to:
  /// **'سيتم مراجعة طلبك خلال 48 ساعة'**
  String get deleteAccountConfirmationDialog;

  /// No description provided for @deleteAccount.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get deleteAccount;

  /// No description provided for @deleteAccountAsk.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف الحساب؟'**
  String get deleteAccountAsk;

  /// No description provided for @book.
  ///
  /// In ar, this message translates to:
  /// **'احجز'**
  String get book;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
