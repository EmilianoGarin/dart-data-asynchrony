import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  int id;
  String title;
  String body;
  String? createdAt;

  Note(this.id, this.title, this.body, this.createdAt);
  
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}