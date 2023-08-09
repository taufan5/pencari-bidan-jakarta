import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustemIcomHome extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function() onpressed;

  const CustemIcomHome({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  imageUrl,
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 212, 208, 208),
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: blackTextStyleSB.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
