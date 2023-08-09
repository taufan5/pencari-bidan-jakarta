import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double fontwidth;
  final Function() onpressed;
  final EdgeInsets margin;

  const CustomButton({
    Key? key,
    required this.title,
    this.fontwidth = double.infinity,
    required this.onpressed,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fontwidth,
      height: 55,
      margin: margin,
      child: TextButton(
        onPressed: onpressed,
        style: TextButton.styleFrom(
          backgroundColor: bluetua,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defauilRadius,
            ),
          ),
        ),
        child: Text(
          title,
          style: whiteTextStyleSB.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
