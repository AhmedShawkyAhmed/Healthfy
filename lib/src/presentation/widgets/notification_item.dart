import 'package:flutter/material.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:sizer/sizer.dart';

class NotificationItem extends StatelessWidget {
  final Color titleBackground;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String name;
  final String date;
  final IconData icon;

  const NotificationItem(
      {super.key,
      required this.titleBackground,
      required this.iconBackground,
      required this.title,
      required this.name,
      required this.date,
      required this.icon,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                color: titleBackground),
            child: Text(
              title,
              style: TextStyle(
                color: iconColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 16, right: 16, top: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.grey6.withOpacity(.7),
                        ),
                        child: Row(
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
