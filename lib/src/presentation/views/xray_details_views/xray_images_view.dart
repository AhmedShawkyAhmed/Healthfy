import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthify/src/data/shared_models/medical_file_data_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../widgets/default_app_text.dart';
import '../../widgets/pick_image_bottom_sheet.dart';

class XRayImagesView extends StatefulWidget {
  const XRayImagesView({
    super.key,
    required this.xrayImages,
    required this.addedXrayImages,
    required this.removedXrayImages,
  });

  final List<MedicalFileData> xrayImages;
  final List<MedicalFileData> addedXrayImages;
  final List<MedicalFileData> removedXrayImages;

  @override
  State<XRayImagesView> createState() => _XRayImagesViewState();
}

class _XRayImagesViewState extends State<XRayImagesView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const DefaultAppText(
                    //text: context.addTheXRay,
                    text: 'أضف مرفقات',
                    color: AppColors.grey1,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  DefaultAppText(
                    text: context.asPhoto,
                    color: AppColors.grey3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              if (widget.xrayImages.isEmpty)
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                      )),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (_) => PickImageBottomSheet(
                        selectImage: (image) {
                          Navigator.pop(context);
                          setState(() {
                            final medicalFile = MedicalFileData(
                              fileType: "image",
                              file: image,
                            );
                            widget.xrayImages.add(medicalFile);
                            widget.addedXrayImages.add(medicalFile);
                          });
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.green),
                        borderRadius: BorderRadius.circular(100)),
                    child:
                        const Icon(Icons.add, size: 16, color: AppColors.green),
                  ),
                ),
              if (widget.xrayImages.isNotEmpty)
                const SizedBox(
                  height: 40,
                )
            ],
          ),
        ),
        if (widget.xrayImages.isNotEmpty)
          SizedBox(
            height: 80,
            child: ListView.separated(
              itemBuilder: (context, index) => index == widget.xrayImages.length
                  ? InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35),
                          )),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          builder: (_) => PickImageBottomSheet(
                            selectImage: (image) {
                              Navigator.pop(context);
                              setState(() {
                                final medicalFile = MedicalFileData(
                                  fileType: "image",
                                  file: image,
                                );
                                widget.xrayImages.add(medicalFile);
                                widget.addedXrayImages.add(medicalFile);
                              });
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.green),
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(Icons.add,
                            size: 24.sp, color: AppColors.green),
                      ),
                    )
                  : Stack(
                      children: [
                        InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              contentPadding: EdgeInsets.zero,
                              children: [
                                widget.xrayImages[index].file.path
                                        .contains("http")
                                    ? Image.network(
                                        widget.xrayImages[index].file.path,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(
                                          widget.xrayImages[index].file.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ],
                            ),
                          ),
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: widget.xrayImages[index].file.path
                                      .contains("http")
                                  ? Image.network(
                                      widget.xrayImages[index].file.path,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(widget.xrayImages[index].file.path),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      title: DefaultAppText(
                                        text: context.delete(context.image),
                                        color: AppColors.grey1,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      content: DefaultAppText(
                                        text: context
                                            .areYouSureToDelete(context.image),
                                        color: AppColors.grey3,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DefaultAppText(
                                            text: context.back,
                                            color: AppColors.grey3,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            onTap: () => Navigator.pop(context),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DefaultAppText(
                                            text: context.confirm,
                                            color: AppColors.defaultRed,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            onTap: () {
                                              setState(() {
                                                final medicalFile = widget
                                                    .xrayImages
                                                    .removeAt(index);
                                                if (medicalFile.file.path
                                                    .contains("http")) {
                                                  widget.removedXrayImages.add(
                                                    medicalFile,
                                                  );
                                                } else {
                                                  widget.addedXrayImages
                                                      .removeAt(index);
                                                }
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.defaultWhite,
                                border: Border.all(color: AppColors.grey5),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.close_rounded,
                              color: AppColors.defaultRed,
                              size: 15.sp,
                            ),
                          ),
                        )
                      ],
                    ),
              itemCount: widget.xrayImages.length + 1,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
      ],
    );
  }
}
