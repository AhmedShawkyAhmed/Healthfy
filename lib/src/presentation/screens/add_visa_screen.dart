import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';

import '../../constants/assets.dart';
import '../widgets/text_input_field.dart';

class AddVisaScreen extends StatefulWidget {
  const AddVisaScreen({super.key});

  @override
  State<AddVisaScreen> createState() => _AddVisaScreenState();
}

class _AddVisaScreenState extends State<AddVisaScreen> {
  TextEditingController visaNumController = TextEditingController();
  TextEditingController visaOwnerNameController = TextEditingController();
  TextEditingController visaCVVController = TextEditingController();
  TextEditingController visaExpiryDateController = TextEditingController();

  bool saveCard = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 60),
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                      context.addNewCard,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.paymentCard,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(AppAssets.imgVisa),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            FieldWithLabel(
              controller: visaNumController,
              label: context.visaNum,
              hasLabel: false,
              keyboardType: TextInputType.number,
            ),
            FieldWithLabel(
              controller: visaOwnerNameController,
              label: context.visaOwner,
              hasLabel: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: FieldWithLabel(
                    controller: visaExpiryDateController,
                    label: context.visaExpiryDate,
                    hasLabel: false,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: FieldWithLabel(
                    controller: visaCVVController,
                    label: context.cvv,
                    hasLabel: false,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Checkbox(
                  value: saveCard,
                  onChanged: (value) {
                    setState(() {
                      saveCard = value!;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
                Text(
                  context.saveCard,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                fixedSize: const Size(double.infinity, 56),
                backgroundColor: AppColors.primary),
            child: Text(
              context.continueT,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
