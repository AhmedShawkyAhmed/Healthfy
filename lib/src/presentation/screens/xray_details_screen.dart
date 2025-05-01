import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/medical_history_cubit/medical_history_cubit.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/request/update_medical_history_request.dart';
import 'package:healthify/src/data/shared_models/medical_file_data_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../data/request/add_medical_history_request.dart';
import '../router/history_arguments.dart';
import '../views/xray_details_views/xray_images_view.dart';
import '../views/xray_details_views/xray_pdfs_view.dart';
import '../widgets/text_input_field.dart';

class XRayDetailsScreen extends StatefulWidget {
  final HistoryArguments medicalHistoryModel;

  const XRayDetailsScreen({
    required this.medicalHistoryModel,
    super.key,
  });

  @override
  State<XRayDetailsScreen> createState() => _XRayDetailsScreenState();
}

class _XRayDetailsScreenState extends State<XRayDetailsScreen> {
  List<TextEditingController> xrayNamesControllers = [TextEditingController()];
  TextEditingController dateController = TextEditingController();
  TextEditingController xrayCenterNameController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.primaryGreen,
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryGreen,
          ),
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child ?? const SizedBox(),
      ),
    );
    if (date != null) {
      dateController.text = DateFormat('y-MM-dd', 'en').format(date);
    }
  }

  final List<MedicalFileData> _xrayImages = [];
  final List<MedicalFileData> _addedXrayImages = [];
  final List<MedicalFileData> _removedXrayImages = [];

  final List<PlatformFile> _files = [];
  final List<PlatformFile> _addedFiles = [];
  final List<PlatformFile> _removedFiles = [];

  @override
  void initState() {
    if (widget.medicalHistoryModel.type == "view") {
      xrayNamesControllers = [
        TextEditingController(
            text: widget.medicalHistoryModel.medicalHistoryModel?.name)
      ];

      dateController.text = widget.medicalHistoryModel.medicalHistoryModel?.date
              ?.substring(0, 10) ??
          '';
      xrayCenterNameController.text =
          widget.medicalHistoryModel.medicalHistoryModel?.medicineType?.name ??
              '';
      for (int i = 0;
          i < widget.medicalHistoryModel.medicalHistoryModel!.medias!.length;
          i++) {
        if (widget.medicalHistoryModel.medicalHistoryModel!.medias?[i].type ==
            "image") {
          _xrayImages.add(MedicalFileData(
              file: XFile(EndPoints.imageBaseUrlGlobal +
                  widget.medicalHistoryModel.medicalHistoryModel!.medias![i]
                      .filename!),
              fileType: widget
                  .medicalHistoryModel.medicalHistoryModel!.medias![i].type!));
        } else {
          _files.add(PlatformFile(
            path: EndPoints.imageBaseUrlGlobal +
                widget.medicalHistoryModel.medicalHistoryModel!.medias![i]
                    .filename!,
            name: 'file ${i + 1}',
            size: 0,
          ));
        }
      }
    } else {
      xrayCenterNameController.text = widget.medicalHistoryModel
              .myReservationModel?.medicineTypeModel?.name ??
          '';
      dateController.text =
          widget.medicalHistoryModel.myReservationModel?.date ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.all(20).copyWith(
              top: 40,
            ),
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
                const Expanded(
                  flex: 10,
                  child: DefaultAppText(
                    text: 'تفاصيل السجل',
                    //  text: context.xrayDetails,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: List.generate(
                        xrayNamesControllers.length,
                        (index) => FieldWithLabel(
                            // readOnly: widget.medicalHistoryModel.type == "view",
                            controller: xrayNamesControllers[index],
                            label: 'اسم السجل',
                            //    label: context.xrayName,
                            borderColor: AppColors.grey3,
                            suffix: xrayNamesControllers.length == 1
                                ? null
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        xrayNamesControllers.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: AppColors.defaultWhite,
                                          border: Border.all(
                                              color: AppColors.defaultRed),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: AppColors.defaultRed,
                                        size: 15.sp,
                                      ),
                                    ),
                                  )),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (xrayNamesControllers.length == 1)
                      DefaultAppText(
                        text: context.addAnotherName,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green,
                        onTap: () {
                          setState(() {
                            xrayNamesControllers.add(TextEditingController());
                          });
                        },
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    FieldWithLabel(
                      controller: dateController,
                      label: context.date,
                      readOnly: true,
                      suffix: const Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.green,
                      ),
                      borderColor: AppColors.grey3,
                      onTap: () => _selectDate(context),
                    ),
                    FieldWithLabel(
                      readOnly: true,
                      controller: xrayCenterNameController,
                      label: 'اسم المركز',
                      //  label: context.xrayCenterName,
                      borderColor: AppColors.grey3,
                    ),
                    XRayImagesView(
                      xrayImages: _xrayImages,
                      addedXrayImages: _addedXrayImages,
                      removedXrayImages: _removedXrayImages,
                    ),
                    XRayPdfsView(
                      files: _files,
                      addedFiles: _addedFiles,
                      removedFiles: _removedFiles,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            child: SizedBox(
              width: double.infinity,
              child: BlocConsumer<MedicalHistoryCubit, MedicalHistoryState>(
                listener: (context, state) {
                  if (state is MedicalHistoryCreateSuccessState ||
                      state is MedicalHistoryUpdateSuccessState) {
                    MedicalHistoryCubit.get(context).getAllMedicalHistory();
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return state is MedicalHistoryCreateLoadingState ||
                          state is MedicalHistoryUpdateLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: widget.medicalHistoryModel.type == "view"
                              ? () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  String? name, date;
                                  if (xrayNamesControllers.first.text.trim() !=
                                      widget.medicalHistoryModel
                                          .medicalHistoryModel!.name!
                                          .trim()) {
                                    name =
                                        xrayNamesControllers.first.text.trim();
                                  }
                                  if (dateController.text.trim() !=
                                      widget.medicalHistoryModel
                                          .medicalHistoryModel?.date
                                          ?.substring(0, 10)
                                          .trim()) {
                                    date = dateController.text.trim();
                                  }
                                  await MedicalHistoryCubit.get(context)
                                      .updateMedicalHistory(
                                    request: UpdateMedicalHistoryRequest(
                                      medicineHistoryId: widget
                                          .medicalHistoryModel
                                          .medicalHistoryModel!
                                          .id!,
                                      name: name,
                                      date: date,
                                      removedFiles: [
                                        ..._removedXrayImages,
                                        ..._removedFiles
                                            .map(
                                              (e) => MedicalFileData(
                                                file: XFile(e.path!),
                                                fileType: "file",
                                              ),
                                            )
                                            .toList(),
                                      ],
                                      addedFiles: [
                                        ..._addedXrayImages,
                                        ..._addedFiles
                                            .map(
                                              (e) => MedicalFileData(
                                                file: XFile(e.path!),
                                                fileType: "file",
                                              ),
                                            )
                                            .toList(),
                                      ],
                                    ),
                                  );
                                }
                              : () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  await MedicalHistoryCubit.get(context)
                                      .addMedicalHistory(
                                    request: AddMedicalHistoryRequest(
                                      medicineTypeId: widget.medicalHistoryModel
                                          .myReservationModel!.medicalTypeId!,
                                      name: xrayNamesControllers[0].text,
                                      date: dateController.text,
                                      medicalFiles: [
                                        ..._xrayImages,
                                        ..._files
                                            .map(
                                              (e) => MedicalFileData(
                                                file: XFile(e.path!),
                                                fileType: "file",
                                              ),
                                            )
                                            .toList(),
                                      ],
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              fixedSize: const Size(double.infinity, 56),
                              backgroundColor: AppColors.primary),
                          child: Text(
                            widget.medicalHistoryModel.type == "view"
                                ? 'تعديل'
                                : context.save,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
