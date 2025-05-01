import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/package_cubit/package_cubit.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/colors.dart';
import '../../router/app_router_names.dart';

class AnnualInsuranceScreen extends StatefulWidget {
  const AnnualInsuranceScreen({super.key});

  @override
  State<AnnualInsuranceScreen> createState() => _AnnualInsuranceScreenState();
}

class _AnnualInsuranceScreenState extends State<AnnualInsuranceScreen> {
  List<bool> selectedSub = [false, false];
  String _radioValue = '1'; //Initial definition of radio button value
  void radioButtonChanges(String? value) {
    PackageCubit.get(context).packageId = value;
    setState(() {
      _radioValue = value!;
      logWarning(_radioValue);
    });
  }

  commonQuestionsList(BuildContext context) => <List<dynamic>>[
        [
          context.whatIsCardBenefits,
          """
1.	\t\tيشمل الاشتراك السنوى العائلى جميع افراد العائله بحد اقصى 5 افراد من خلال كارت خاص بكل فرد من افراد العائله لسهولة الحصول على الخصومات الطبيه لجميع افراد العائله بدون اى قيود او اجراءات روتينيه.
          
2.	\t\t.توفير نسبة خصم تصل حتي ( %60  ) علي كافة الخدمات الطبية المقدمة من خلال المؤسسات الطبية المتعاقدة معنا
          
3.	\t\t.سهولة الحصول علي جميع الخصومات المتاحة بشكل فوري عند الاستفادة من اي خدمة من الخدمات المقدمة بمجرد اظهار كارت صحتك تهمنا الخاص بك عند تواجدك داخل المؤسسة الطبية بدون اي شروط او اجراءات روتينية
          
4.	\t\t.الاستفادة من كافة الخدمات الطبية المتاحة في اكثر من 1,000 مؤسسة طبية متعاقدة معنا في جميع أنحاء الأسكندرية والتي تشمل عدد كبير من المستشفيات الخاصة والعيادات الخاصة في كل التخصصات من أكفا الاطباء الذين يقدمون مستوي متميز من الرعاية الصحية ومراكز الأشعة ومعامل التحاليل والصيدليات ومراكز البصريات والمستلزمات الطبية
          
5.	\t\t.الخصومات تشمل؛ العلاج الداخلي للمستشفيات وخدمات العيادات الخارجية وحالات الطوارئ وتغطية مصاريف الحمل والولادة وعلاج الأسنان وعلاج النظر وأصحاب الأمراض المزمنة، توفير الأدوية بأقصي نسبة خصم من خلال الصيدليات المتعاقدة معنا ومراكز الأشعة ومعامل التحاليل كما تشمل خدمات الرعاية المنزلية والتمريض المنزلي والاسعاف
          """,
        ],
        [
          context.paymentMethods,
          """
1.	\t\tالدفع عند الاستلام.
          
2.	\t\tجميع انواع البطاقات البنكية ( بطاقات الخصم المباشر - بطاقات المشتريات ).

3.  \t\t جميع انواع المحافظ الالكترونية.
         """,
        ]
      ];

  @override
  void initState() {
    super.initState();
    PackageCubit.get(context)
      ..idle()
      ..getHealthPackage()
      ..getMyHealthPackage();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<PackageCubit, PackageState>(
        builder: (context, state) {
          if (state is GetMyPackageLoading || state is GetPackageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 40,
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  color: AppColors.primary,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          context.insuranceCard,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (PackageCubit.get(context)
                        .myPackageResponse
                        ?.data
                        ?.myPackage !=
                    null) ...[
                  Column(
                    children: [
                      Text(
                        "خطتك الاشتراكية الحالية",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "استمتع بخصومات حصرية",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: PackageCubit.get(context).type != "upgrade",
                    replacement: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 50,
                            left: 30,
                            right: 30,
                          ),
                          child: SizedBox(
                            width: 100.w,
                            // height: 330,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 0,
                                childAspectRatio: (5.2 / 9),
                              ),
                              itemCount: PackageCubit.get(context)
                                  .packageResponse
                                  ?.data
                                  ?.package
                                  ?.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Positioned.fill(
                                      child: GestureDetector(
                                        onTap: () => radioButtonChanges(
                                            PackageCubit.get(context)
                                                .packageResponse
                                                ?.data
                                                ?.package?[index]
                                                .id
                                                .toString()),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                            color: _radioValue ==
                                                    PackageCubit.get(context)
                                                        .packageResponse
                                                        ?.data
                                                        ?.package?[index]
                                                        .id
                                                        .toString()
                                                ? AppColors.green
                                                    .withOpacity(0.1)
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: _radioValue ==
                                                    PackageCubit.get(context)
                                                        .packageResponse
                                                        ?.data
                                                        ?.package?[index]
                                                        .id
                                                        .toString()
                                                ? Border.all(
                                                    color: Colors.green)
                                                : null,
                                            boxShadow: _radioValue ==
                                                    PackageCubit.get(context)
                                                        .packageResponse
                                                        ?.data
                                                        ?.package?[index]
                                                        .id
                                                        .toString()
                                                ? null
                                                : [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 0),
                                                        blurRadius: 20,
                                                        spreadRadius: 0)
                                                  ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Radio(
                                                value: PackageCubit.get(context)
                                                        .packageResponse
                                                        ?.data
                                                        ?.package?[index]
                                                        .id
                                                        .toString() ??
                                                    "",
                                                groupValue: _radioValue,
                                                onChanged: radioButtonChanges,
                                                activeColor: AppColors.green,
                                              ),
                                              Text(
                                                PackageCubit.get(context)
                                                        .packageResponse
                                                        ?.data
                                                        ?.package?[index]
                                                        .name ??
                                                    "",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              PackageCubit.get(context)
                                                          .packageResponse
                                                          ?.data
                                                          ?.package?[index]
                                                          .id ==
                                                      0
                                                  ? Expanded(
                                                      child: Image.asset(
                                                          'assets/images/individual.png'),
                                                    )
                                                  : Image.asset(
                                                      'assets/images/annual.png'),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                '${PackageCubit.get(context).packageResponse?.data?.package?[index].oldPrice ?? 0} جنيه',
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 10,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationThickness: 2,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                '${PackageCubit.get(context).packageResponse?.data?.package?[index].price ?? 0} جنيه',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (PackageCubit.get(context)
                                            .packageResponse
                                            ?.data
                                            ?.package?[index]
                                            .name ==
                                        "عائلى")
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(8)),
                                            color: Colors.black,
                                          ),
                                          child: const DefaultAppText(
                                            text: "يشمل 5 افراد من العائلة",
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    if (PackageCubit.get(context)
                                            .packageResponse
                                            ?.data
                                            ?.package?[index]
                                            .mostSale ==
                                        1)
                                      Positioned(
                                        left: -13,
                                        top: 35,
                                        child: Transform.rotate(
                                          angle: 5.5,
                                          child: Container(
                                            height: 22,
                                            width: 120,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.red,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const DefaultAppText(
                                              text: "الاكثر مبيعا",
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 90),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                PackageCubit.get(context).packageId =
                                    _radioValue;
                                if (_radioValue == "2") {
                                  Navigator.pushNamed(
                                      context, AppRouterNames.rFamilyInsurance);
                                } else {
                                  Navigator.pushNamed(context,
                                      AppRouterNames.rIndividualInsurance);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: const Size(double.infinity, 48),
                                  backgroundColor: AppColors.primary),
                              child: Text(
                                context.subscribeNow,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 30, right: 30),
                      child: SizedBox(
                        width: 100.w,
                        height: 35.h,
                        child: Container(
                          height: 180,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 0),
                                  blurRadius: 20,
                                  spreadRadius: 0)
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "الخطة الحالية",
                                style: TextStyle(
                                  color: AppColors.defaultGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                PackageCubit.get(context)
                                        .myPackageResponse
                                        ?.data
                                        ?.myPackage
                                        ?.myPackage
                                        ?.name ??
                                    "",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              PackageCubit.get(context)
                                          .myPackageResponse!
                                          .data!
                                          .myPackage!
                                          .myPackage!
                                          .id ==
                                      1
                                  ? Image.asset('assets/images/individual.png')
                                  : Image.asset('assets/images/annual.png'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'الاشتراك: ${PackageCubit.get(context).myPackageResponse?.data?.myPackage?.startAt}',
                                    style: const TextStyle(
                                      color: AppColors.grey3,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'الانتهاء: ${PackageCubit.get(context).myPackageResponse?.data?.myPackage?.endAt}',
                                    style: const TextStyle(
                                      color: AppColors.grey3,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      PackageCubit.get(context)
                                          .renewSubscribePackage(
                                              packageId:
                                                  PackageCubit.get(context)
                                                      .myPackageResponse!
                                                      .data!
                                                      .myPackage!
                                                      .myPackage!
                                                      .id!,
                                              afterSuccess: () {
                                                Navigator.pop(context);
                                              });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: AppColors.blue1,
                                          border: Border.all(
                                            color: AppColors.blue1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const Text(
                                        "تجديد الخطة",
                                        style: TextStyle(
                                          color: AppColors.defaultWhite,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        PackageCubit.get(context).type =
                                            "upgrade";
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: AppColors.defaultWhite,
                                          border: Border.all(
                                            color: AppColors.blue1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const Text(
                                        "تغيير الخطة",
                                        style: TextStyle(
                                          color: AppColors.blue1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    context.chooseSubscription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    context.andGetDiscount,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 30,
                      right: 30,
                    ),
                    child: SizedBox(
                      width: 100.w,
                      height: 310,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 0,
                            childAspectRatio: (5.2 / 9),
                          ),
                          itemCount: PackageCubit.get(context)
                              .packageResponse
                              ?.data
                              ?.package
                              ?.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: () => radioButtonChanges(
                                        PackageCubit.get(context)
                                            .packageResponse
                                            ?.data
                                            ?.package?[index]
                                            .id
                                            .toString()),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _radioValue ==
                                                PackageCubit.get(context)
                                                    .packageResponse
                                                    ?.data
                                                    ?.package?[index]
                                                    .id
                                                    .toString()
                                            ? AppColors.green.withOpacity(0.1)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: _radioValue ==
                                                PackageCubit.get(context)
                                                    .packageResponse
                                                    ?.data
                                                    ?.package?[index]
                                                    .id
                                                    .toString()
                                            ? Border.all(color: Colors.green)
                                            : null,
                                        boxShadow: _radioValue ==
                                                PackageCubit.get(context)
                                                    .packageResponse
                                                    ?.data
                                                    ?.package?[index]
                                                    .id
                                                    .toString()
                                            ? null
                                            : [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: const Offset(0, 0),
                                                    blurRadius: 20,
                                                    spreadRadius: 0)
                                              ],
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Radio(
                                              value: PackageCubit.get(context)
                                                      .packageResponse
                                                      ?.data
                                                      ?.package?[index]
                                                      .id
                                                      .toString() ??
                                                  "",
                                              groupValue: _radioValue,
                                              onChanged: radioButtonChanges,
                                              activeColor: AppColors.green,
                                            ),
                                            Text(
                                              PackageCubit.get(context)
                                                      .packageResponse
                                                      ?.data
                                                      ?.package?[index]
                                                      .name ??
                                                  "",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            PackageCubit.get(context)
                                                        .packageResponse
                                                        ?.data
                                                        ?.package?[index]
                                                        .id ==
                                                    0
                                                ? Image.asset(
                                                    'assets/images/individual.png')
                                                : Image.asset(
                                                    'assets/images/annual.png'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              '${PackageCubit.get(context).packageResponse?.data?.package?[index].oldPrice ?? 0} جنيه',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 10,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationThickness: 2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              '${PackageCubit.get(context).packageResponse?.data?.package?[index].price ?? 0} جنيه',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (PackageCubit.get(context)
                                        .packageResponse
                                        ?.data
                                        ?.package?[index]
                                        .name ==
                                    "عائلى")
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                        color: Colors.black,
                                      ),
                                      child: const DefaultAppText(
                                        text: "يشمل 5 افراد من العائلة",
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                if (PackageCubit.get(context)
                                        .packageResponse
                                        ?.data
                                        ?.package?[index]
                                        .mostSale ==
                                    1)
                                  Positioned(
                                    left: -13,
                                    top: 35,
                                    child: Transform.rotate(
                                      angle: 5.5,
                                      child: Container(
                                        height: 22,
                                        width: 120,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.red,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const DefaultAppText(
                                          text: "الاكثر مبيعا",
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 90),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          PackageCubit.get(context).packageId = _radioValue;
                          if (_radioValue == "2") {
                            Navigator.pushNamed(
                                context, AppRouterNames.rFamilyInsurance);
                          } else {
                            Navigator.pushNamed(
                                context, AppRouterNames.rIndividualInsurance);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fixedSize: const Size(double.infinity, 48),
                            backgroundColor: AppColors.primary),
                        child: Text(
                          context.subscribeNow,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.commonQuestions,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                          children: List.generate(
                        commonQuestionsList(context).length,
                        (index) => ExpansionTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: AppColors.defaultWhite,
                          collapsedBackgroundColor: AppColors.defaultWhite,
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: DefaultAppText(
                              text: commonQuestionsList(context)[index][0],
                              textAlign: TextAlign.center,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          children: [
                            DefaultAppText(
                              text: commonQuestionsList(context)[index][1],
                              textAlign: TextAlign.start,
                              fontSize: 11.sp,
                              lineHeight: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
