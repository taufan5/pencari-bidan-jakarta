import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:map_flutter/shared/theme.dart';

class DetailImunisasi extends StatelessWidget {
  DocumentSnapshot documentSnapshot3;
  DetailImunisasi({super.key, required this.documentSnapshot3});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Note"),
          backgroundColor: bluetua,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              FullScreenWidget(
                child: Image.network(
                  documentSnapshot3['fotokiaimunisasi'],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //NOTE:
                    Text(
                      'Imunisasi',
                      style: blackTextStyleSB.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      documentSnapshot3['imunisasi'],
                      style: blackTextStyleSB.copyWith(
                        height: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tanggal',
                      style: blackTextStyleSB.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      documentSnapshot3['tanggal'],
                      style: blackTextStyleSB.copyWith(
                        height: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tempat Periksa',
                      style: blackTextStyleSB.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      documentSnapshot3['tempat'],
                      style: blackTextStyleSB.copyWith(
                        height: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Catatan',
                      style: blackTextStyleSB.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      documentSnapshot3['catatan'],
                      style: blackTextStyleSB.copyWith(
                        height: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
