// ignore: file_names
import '1-task.dart';
import 'dart:convert';


List<User> parseUsers(String jsonStr) {
  //esto puede retornar una lista con map donde cada uno es un Usuario
  List<dynamic> usersJson = json.decode(jsonStr); 

  //esta linea recorre la lista y la convierte en una lista de usuarios
  List<User> users = usersJson.map((json) => User.fromJson(json)).toList();
  return users;
}

void main() {
  String jsonStr = '[{"id": 1,"name": "Leanne Graham","email": "Sincere@april.biz"},{"id": 2,"name": "Ervin Howell","email": "Shanna@melissa.tv"}]';

  List<User> users = parseUsers(jsonStr);

  for (User user in users) {
    user.printUser();
  }
}
