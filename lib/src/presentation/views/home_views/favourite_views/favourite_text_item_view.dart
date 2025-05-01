import 'package:flutter/material.dart';
import 'package:healthify/src/constants/extensions.dart';

class FavouriteTextItemView extends StatelessWidget {
  const FavouriteTextItemView({
    super.key,
    required this.icon,
    required this.text,
    required this.textColor,
  });

  final Widget icon;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveHeight(4),
      ),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: context.responsiveWidth(4),
          ),
          Expanded(
            // width: text.length < 20 ? 20.w : 50.w,
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
