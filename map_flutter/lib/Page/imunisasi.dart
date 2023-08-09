import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_flutter/Page/detail_imunisasi.dart';
import 'package:map_flutter/Page/home.dart';
import 'package:map_flutter/Page/note_imunisasi.dart';
import 'package:map_flutter/widgets/custom_card_imunisasi.dart';
import '../shared/theme.dart';

class Imunisasi extends StatefulWidget {
  const Imunisasi({super.key});

  @override
  State<Imunisasi> createState() => _ImunisasiState();
}

class _ImunisasiState extends State<Imunisasi> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> imunisasiStream =
        FirebaseFirestore.instance.collection('noteimunisasi').snapshots();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteImunisasi(),
            ),
          );
        },
        backgroundColor: red300Color,
        tooltip: 'tambah',
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/bagrountimunisasi.png',
                    ),
                  ),
                ),
                child: Container(
                  width: 75,
                  height: 75,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/imunisasi.png',
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Note Pribadi Pemeriksaan Ibu Hamil",
                            style: whiteTextStyleSB.copyWith(
                                fontSize: 16, fontWeight: bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "mencatat mandiri",
                            style: whiteTextStyleSB.copyWith(
                                fontSize: 14, fontWeight: light),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 600,
                margin: const EdgeInsets.only(top: 130),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defauilRadius),
                ),
                child: StreamBuilder<QuerySnapshot>(
                    stream: imunisasiStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            User? user = FirebaseAuth.instance.currentUser;
                            if (documentSnapshot['userid'] == user!.uid) {
                              final itemID = documentSnapshot;
                              return Dismissible(
                                key: Key(itemID.toString()),
                                onDismissed: (direction) {
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection('noteimunisasi')
                                        .doc(documentSnapshot.id)
                                        .delete();
                                  });
                                },
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Confirm"),
                                        content: Text(
                                            "Apakah kamu yakin menghapus item ini ?"),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: Text("No")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text("Yes")),
                                        ],
                                      );
                                    },
                                  );
                                },
                                background: Container(
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete_forever_rounded,
                                    size: 32,
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                child: CustomCardImunisasi(
                                  namaIm: documentSnapshot['imunisasi'],
                                  tanggalIm: documentSnapshot['tanggal'],
                                  onpressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailImunisasi(
                                            documentSnapshot3:
                                                documentSnapshot),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      }
                    }),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(left: 15, top: 15),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/arrowl.png',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
