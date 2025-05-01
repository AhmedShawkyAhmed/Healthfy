import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/widgets/custom_button.dart';
import 'package:healthify/src/presentation/widgets/default_app_text.dart';

class DeleteAccountConfirmDialog extends StatelessWidget {
  const DeleteAccountConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: DefaultAppText(
                text: context.deleteAccount,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DefaultAppText(
              text: context.deleteAccountAsk,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: context.confirm,
                    onTap: () {
                      context.deleteAccountConfirmationDialog.toToastSuccess();
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CustomButton(
                    backgroundColor: AppColors.defaultRed,
                    text: context.cancel(""),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
