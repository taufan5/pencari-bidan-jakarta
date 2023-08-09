import 'package:flutter/material.dart';
import '../shared/theme.dart';

class CustomListTile extends StatelessWidget {
  final String namabidan;
  final String jarak;
  final Function() onpressed;

  const CustomListTile({
    super.key,
    required this.namabidan,
    required this.jarak,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.only(left: 5, top: 20, right: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgoudColor,
          borderRadius: BorderRadius.circular(18),
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
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/midwife.png',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bidan $namabidan",
                  style:
                      blackTextStyleSB.copyWith(fontSize: 18, fontWeight: bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/pin.png",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "$jarak KM",
                      style: blackTextStyleSB.copyWith(
                          fontSize: 12, fontWeight: bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
