import 'package:flutter/material.dart';
import '../shared/theme.dart';

class CustomCardBumil extends StatelessWidget {
  final String nama;
  final String tanggal;
  final Function() onpressed;

  const CustomCardBumil({
    super.key,
    required this.nama,
    required this.tanggal,
    required this.onpressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/notebumil.png',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pemeriksaan $nama",
                    style: blackTextStyleSB.copyWith(
                        fontSize: 18, fontWeight: bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        tanggal,
                        style: blackTextStyleSB.copyWith(
                            fontSize: 12, fontWeight: bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
