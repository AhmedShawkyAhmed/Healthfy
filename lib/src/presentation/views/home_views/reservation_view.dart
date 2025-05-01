import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:sizer/sizer.dart';

class ReservationView extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback onTap;
  final VoidCallback onCancel;

  const ReservationView({
    Key? key,
    required this.title,
    required this.status,
    required this.onTap,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 65.w,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: AppColors.bGrey,
              blurRadius: 4,
              spreadRadius: 3,
            ),
          ],
          gradient: const LinearGradient(
            colors: [AppColors.bGrey2,AppColors.defaultWhite],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          color: AppColors.defaultWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "حجز $title",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Alexandria',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 20.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: AppColors.blue1.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        status == "waiting" ? "في انتظار التأكيد" : status,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 9,
                          color: AppColors.blue1,
                          fontFamily: 'Alexandria',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward_ios,size: 15.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
