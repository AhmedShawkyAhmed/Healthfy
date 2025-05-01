import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

class DeleteDeliveryLocationDialog extends StatelessWidget {
  const DeleteDeliveryLocationDialog({super.key, required this.remove});

  final Function() remove;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationDeleteLocationSuccessState ||
            state is LocationDeleteLocationFailureState) {
          Navigator.pop(context);
        }
      },
      child: Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.responsiveHeight(24),
            horizontal: context.responsiveWidth(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "حذف العنوان؟",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Alexandria',
                ),
              ),
              SizedBox(
                height: context.responsiveHeight(24),
              ),
              const Text(
                "هل انت متأكد من حذف هذا العنوان من قائمتك؟",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Alexandria',
                ),
              ),
              SizedBox(
                height: context.responsiveHeight(48),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      context.back,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Alexandria',
                        color: AppColors.grey3,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.responsiveWidth(24),
                  ),
                  InkWell(
                    onTap: remove,
                    child: Text(
                      context.confirm,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Alexandria',
                        color: AppColors.red,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
