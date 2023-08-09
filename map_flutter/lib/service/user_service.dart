import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        name: snapshot['name'],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Future<BumilModel> getIdBumil(String id) async {
  //   try {
  //     DocumentSnapshot snapshot = await _userReference.doc().get();
  //     return BumilModel(
  //       id: id,
  //       pemeriksaan: snapshot['pemeriksaan'],
  //       tempat: snapshot['tempat'],
  //       tanggal: snapshot['tanggal'],
  //       catatan: snapshot['catatan'],
  //       kiabumil: snapshot['kiabumil'],
  //       userId: snapshot.get(id)
  //     );
  //   } catch (e) {return e;}
  // }
}
