import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class ImunisasiModel extends Equatable {
  final String id;
  final String imunisasi;
  final String tempat;
  final String tanggal;
  final String catatan;
  final FilePicker kiaimunisasi;
  final String userId;

  const ImunisasiModel({
    required this.id,
    this.imunisasi = '',
    this.tempat = '',
    this.tanggal = '',
    this.catatan = '',
    required this.kiaimunisasi,
    required this.userId,
  });

  factory ImunisasiModel.fromjson(String id, Map<String, dynamic> json) =>
      ImunisasiModel(
        id: id,
        imunisasi: json['pemeriksaan'],
        tempat: json['tempat'],
        tanggal: json['tanggal'],
        catatan: json['catatan'],
        kiaimunisasi: json['kiabumil'],
        userId: json['userId'],
      );

  @override
  List<Object?> get props =>
      [id, imunisasi, tempat, tanggal, catatan, kiaimunisasi, userId];
}
