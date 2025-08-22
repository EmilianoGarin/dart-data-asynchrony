import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  int id;
  String name;
  String email;

  User.fromJson(Map<String, dynamic> json) 
    : id = json['id'],
      name = json['name'],
      email = json['email'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'name': name,
      'email': email,
    };
    return json;
  }

  void printUser() {
    print('ID: $id, Name: $name, Email: $email');
  }
}

Future<Map<String, dynamic>> getJsonResponse(String url) async {
  try {
     final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener datos de la API');
    }
  } catch (e) {
    // Manejo de errores de conexión o http
    print('Ocurrió un error: $e');
    throw Exception('Ocurrió un error al procesar la solicitud: $e'); // Lanzo una excepción
  }
}

void main() async {
  User usuario = User.fromJson(await getJsonResponse('https://jsonplaceholder.typicode.com/users/1'));

  usuario.printUser();
  
  print("");

  Map<String, dynamic> json = usuario.toJson();
  print(json);

  
}