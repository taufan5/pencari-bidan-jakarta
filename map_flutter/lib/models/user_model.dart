import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  factory UserModel.fromjson(String id, Map<String, dynamic> json) => UserModel(
        id: id,
        email: json['email'],
        name: json['name'],
      );

  @override
  List<Object?> get props => [id, email, name];
}
