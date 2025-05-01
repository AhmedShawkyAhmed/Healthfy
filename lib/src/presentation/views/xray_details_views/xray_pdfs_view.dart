import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/const_methods.dart';
import '../../router/app_router_names.dart';
import '../../widgets/default_app_text.dart';

class XRayPdfsView extends StatefulWidget {
  const XRayPdfsView({
    super.key,
    required this.files,
    required this.addedFiles,
    required this.removedFiles,
  });

  final List<PlatformFile> files;
  final List<PlatformFile> addedFiles;
  final List<PlatformFile> removedFiles;

  @override
  State<XRayPdfsView> createState() => _XRayPdfsViewState();
}

class _XRayPdfsViewState extends State<XRayPdfsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const DefaultAppText(
                    //  text: context.addTheXRay,
                    text: 'أضف مرفقات',
                    color: AppColors.grey1,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  DefaultAppText(
                    text: context.asPDF,
                    color: AppColors.grey3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              if (widget.files.isEmpty)
                InkWell(
                  onTap: () {
                    pickFile(
                      onFileSelect: (file) {
                        setState(() {
                          widget.files.add(file);
                          widget.addedFiles.add(file);
                        });
                      },
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
                )
            ],
          ),
        ),
        if (widget.files.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.separated(
              itemBuilder: (context, index) => index == widget.files.length
                  ? InkWell(
                      onTap: () {
                        pickFile(
                          onFileSelect: (file) {
                            setState(() {
                              widget.files.add(file);
                              widget.addedFiles.add(file);
                            });
                          },
                        );
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        margin: const EdgeInsets.only(bottom: 20),
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
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRouterNames.rPDFView,
                                arguments: widget.files[index]);
                          },
                          child: SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue1,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Image.asset(
                                    AppAssets.icPDF,
                                    scale: 1.1,
                                  ),
                                ),
                                DefaultAppText(
                                  text: widget.files[index].name,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
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
                                        text: context.delete(context.pdf),
                                        color: AppColors.grey1,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      content: DefaultAppText(
                                        text: context
                                            .areYouSureToDelete(context.pdf),
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
                                                final medicalFile = widget.files
                                                    .removeAt(index);
                                                if (medicalFile.path!
                                                    .contains("http")) {
                                                  widget.removedFiles.add(
                                                    medicalFile,
                                                  );
                                                } else {
                                                  widget.addedFiles
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
              itemCount: widget.files.length + 1,
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
