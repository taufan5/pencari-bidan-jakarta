import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import '../shared/theme.dart';

class DetailBumil extends StatelessWidget {
  DocumentSnapshot documentSnapshot2;
  DetailBumil({Key? key, required this.documentSnapshot2}) : super(key: key);

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
                  child: Image.network(documentSnapshot2['fotokiabumil'])),
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
                      'Pemeriksaan',
                      style: blackTextStyleSB.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      documentSnapshot2['pemeriksaan'],
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
                      documentSnapshot2['tanggal'],
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
                      documentSnapshot2['tempat'],
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
                      documentSnapshot2['pemeriksaan'],
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
