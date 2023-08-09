import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_flutter/Page/bidan.dart';
import 'package:map_flutter/Page/home.dart';
import 'package:map_flutter/widgets/custom_list_tile.dart';
import '../shared/theme.dart';

class ListBidan extends StatefulWidget {
  const ListBidan({super.key});

  @override
  State<ListBidan> createState() => _ListBidanState();
}

class _ListBidanState extends State<ListBidan> {
  Position? _currentUserPosition;
  double? distanceImMeter = 0.0;
  String name = "";

  Future getTheDistance() async {
    var collection = FirebaseFirestore.instance.collection('bidan');
    var querySnapshots = await collection.get();
    _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    
    FirebaseFirestore.instance
        .collection('bidan')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        distanceImMeter = Geolocator.distanceBetween(
          _currentUserPosition!.latitude,
          _currentUserPosition!.longitude,
          double.parse(doc['latitude']),
          double.parse(doc['longitude']),
        );

        var distance = distanceImMeter?.round().toInt();
        var jumlah = (distance! / 1000).toString();

        for (var i = 0; i < querySnapshots.docs.length; i++) {
          doc.reference.update({'distance': jumlah});
        }
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    determinePosition();
    getTheDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> bidanStream = FirebaseFirestore.instance
        .collection('bidan')
        .orderBy('distance', descending: false)
        .snapshots();

    return Scaffold(
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
                      'assets/bagrountbidan.png',
                    ),
                  ),
                ),
                child: Container(
                  width: 75,
                  height: 120,
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Row(
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
                                  'assets/mapbidan.png',
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
                                "Daftar Praktek Mandiri Bidan",
                                style: whiteTextStyleSB.copyWith(
                                    fontSize: 16, fontWeight: bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Jarak Terdekat",
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
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search nama...'),
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 600,
                margin: const EdgeInsets.only(top: 180),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(defauilRadius),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: bidanStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          if (name.isEmpty) {
                            return CustomListTile(
                              namabidan: documentSnapshot['name'],
                              jarak: documentSnapshot['distance'],
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Bidan(
                                        documentSnapshot: documentSnapshot),
                                  ),
                                );
                              },
                            );
                          }
                          if (documentSnapshot['name']
                              .toString()
                              .toLowerCase()
                              .startsWith(name.toLowerCase())) {
                            return CustomListTile(
                              namabidan: documentSnapshot['name'],
                              jarak: documentSnapshot['distance'],
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Bidan(
                                        documentSnapshot: documentSnapshot),
                                  ),
                                );
                              },
                            );
                          }
                          return Container();
                        },
                      );
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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












                      // return ListView(
                      //   physics: const AlwaysScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   padding: const EdgeInsets.only(bottom: 100),
                      //   children: snapshot.data!.docs
                      //       .map((DocumentSnapshot document) {
                      //     Map<String, dynamic> data =
                      //         document.data()! as Map<String, dynamic>;
                      //     return CustomListTile(
                      //       namabidan: data['name'],
                      //       jarak: data['distance'],
                      //       onpressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => Bidan(),
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   }).toList(),
                      // );