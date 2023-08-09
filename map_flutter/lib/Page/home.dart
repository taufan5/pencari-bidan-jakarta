import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_flutter/Page/ibu_hamil.dart';
import 'package:map_flutter/Page/imunisasi.dart';
import 'package:map_flutter/Page/list_bidan.dart';
import 'package:map_flutter/Page/pengetahuan.dart';
import 'package:map_flutter/Page/profile_user.dart';
import 'package:map_flutter/widgets/custom_icon_header.dart';
import 'package:map_flutter/widgets/cutom_arikel.dart';
import '../service/pdf_api.dart';
import '../shared/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 268,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/homebg.png',
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    child: AutoSizeText(
                      "Mencari Praktek Mandiri Bidan\nDisekitar Kecamatan\nCengkareng",
                      style: whiteTextStyleSB.copyWith(fontWeight: semiBold),
                      minFontSize: 18,
                      maxFontSize: 24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      margin: const EdgeInsets.only(right: 10, top: 40),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/user.png"))),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 600,
              margin: const EdgeInsets.only(top: 150),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defauilRadius)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustemIcomHome(
                          title: "Bidan",
                          imageUrl: "assets/mapbidan.png",
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListBidan(),
                              ),
                            );
                          },
                        ),
                        CustemIcomHome(
                          title: "Ibu Hamil",
                          imageUrl: "assets/ibuhamil.png",
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const IbuHamil(),
                              ),
                            );
                          },
                        ),
                        CustemIcomHome(
                          title: "Imunisasi",
                          imageUrl: "assets/imunisasi.png",
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Imunisasi(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Informasi',
                      style: blackTextStyleSB.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                    CustomArtikel(
                      informasi: "Informasi mengenai ibu hamil",
                      onpressed: () async {
                        final url = 'kiaibu.pdf';
                        final file = await PDFApi.loadFirebase(url);

                        if (file == null) return;
                        openPDF(context, file);
                      },
                    ),
                    CustomArtikel(
                      informasi: "Informasi Imunisasi anak",
                      onpressed: () async {
                        final url = 'kiaanak.pdf';
                        final file = await PDFApi.loadFirebase(url);

                        if (file == null) return;
                        openPDF(context, file);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}

void determinePosition() async {
  // Test if location services are enabled.
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    print('Location services are disabled.');
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      print('Location permissions are denied');
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    print(
        'Location permissions are permanently denied, we cannot request permissions.');

    /// open app settings so that user changes permissions
    // await Geolocator.openAppSettings();
    // await Geolocator.openLocationSettings();

    return;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.

  // Position position = await Geolocator.getCurrentPosition();
  // print("Current Position $position");
  // setState(() {
  //   currentPosition = position;
  // });
}
