import 'package:json_annotation/json_annotation.dart';

part "user.g.dart"; // Agrega esta línea

@JsonSerializable() // Agrega esta anotación
class User {
  int id;
  String name;
  String email;

  User(this.id, this.name, this.email);
}