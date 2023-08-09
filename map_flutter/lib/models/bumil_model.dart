import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:map_flutter/models/user_model.dart';

class BumilModel extends Equatable {
  final String id;
  final String pemeriksaan;
  final String tempat;
  final String tanggal;
  final String catatan;
  final FilePicker kiabumil;
  final UserModel userId;

  const BumilModel({
    required this.id,
    required this.pemeriksaan,
    required this.tempat,
    required this.tanggal,
    required this.catatan,
    required this.kiabumil,
    required this.userId,
  });

  factory BumilModel.fromjson(String id, Map<String, dynamic> json) =>
      BumilModel(
        id: id,
        pemeriksaan: json['pemeriksaan'],
        tempat: json['tempat'],
        tanggal: json['tanggal'],
        catatan: json['catatan'],
        kiabumil: json['kiabumil'],
        userId: json['userId'],
      );

  @override
  List<Object?> get props =>
      [id, pemeriksaan, tempat, tanggal, catatan, kiabumil, userId];
}
