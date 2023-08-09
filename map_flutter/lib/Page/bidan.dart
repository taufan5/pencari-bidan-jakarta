import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_flutter/Page/location_map.dart';
import '../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/interest_item.dart';

class Bidan extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const Bidan({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 450,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/bgbidan2.png"),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 209,
              margin: const EdgeInsets.only(
                top: 236,
              ),
              //shadow buat bawah burem
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    whiteColor.withOpacity(0),
                    Colors.black.withOpacity(0.99),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [
                  //NOTE: EMBLEM
                  Container(
                    width: 108,
                    height: 24,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/emblem.png',
                        ),
                      ),
                    ),
                  ),
                  //NOTE: TITEL AND RATING
                  Container(
                    height: 60,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 270,
                    ),
                    child: Row(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Praktek Mandiri Bidan',
                                  style: whiteTextStyleSB.copyWith(
                                      fontSize: 24, fontWeight: bold)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: whiteColor,
                                  ),
                                  Text(
                                    documentSnapshot['distance'],
                                    style: whiteTextStyleSB.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //NOTE: DESCRIBTION
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            documentSnapshot['name'],
                            style: blackTextStyleSB.copyWith(
                              fontSize: 24,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //NOTE: ABOUT
                        Text(
                          'Alamat',
                          style: blackTextStyleSB.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          documentSnapshot['alamat'],
                          style: blackTextStyleSB.copyWith(
                            height: 2,
                          ),
                        ),
                        //NOTE PHOTOS
                        const SizedBox(
                          height: 20,
                        ),

                        //NOTE: INTERESTS
                        Text(
                          'Pelayanan',
                          style: blackTextStyleSB.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            InterestItem(
                              title: 'Imunisasi',
                            ),
                            InterestItem(
                              title: 'Pelayanan KB',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            InterestItem(
                              title: 'Konsultasi',
                            ),
                            InterestItem(
                              title: 'Periksa Hamil',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            InterestItem(
                              title: 'Periksa Bayi',
                            ),
                            InterestItem(
                              title: 'Persalinan',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            InterestItem(
                              title: 'Periksa Nifas',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Jam Praktik',
                          style: blackTextStyleSB.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Buka Praktik Setiap Hari\nPagi : 08:00-12:00 WIB\nSore : 16:00-21:00 WIB\nSiang Istirahat\nKhusus Persalinan Buka 24 Jam',
                          style: blackTextStyleSB.copyWith(
                            fontSize: 16,
                            fontWeight: normal,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Kontak',
                          style: blackTextStyleSB.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone_callback_rounded),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              documentSnapshot['telfon'].toString(),
                              style: blackTextStyleSB.copyWith(
                                fontSize: 16,
                                fontWeight: normal,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // NOTE: list an map
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          title: "List Bidan",
                          onpressed: () {
                            Navigator.pop(context);
                          },
                          fontwidth: 150,
                        ),

                        //NOTE: BUUTON BOOK
                        CustomButton(
                          title: 'Map',
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationMap(
                                  documentSnapshot2: documentSnapshot,
                                ),
                              ),
                            );
                          },
                          fontwidth: 150,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
