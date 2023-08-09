import 'package:flutter/material.dart';
import 'package:map_flutter/shared/theme.dart';

class CustomArtikel extends StatelessWidget {
  final String informasi;
  final Function() onpressed;

  const CustomArtikel({
    Key? key,
    required this.informasi,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.only(left: 5, top: 20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: backgoudColor,
                borderRadius: BorderRadius.circular(18),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/file2.png',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    informasi,
                    style: blackTextStyleSB.copyWith(
                        fontSize: 16, fontWeight: bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Sumber buku KIA",
                    style: blackTextStyleSB.copyWith(
                        fontSize: 14, fontWeight: light),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 10,
                height: 20,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/vektor1.png',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
