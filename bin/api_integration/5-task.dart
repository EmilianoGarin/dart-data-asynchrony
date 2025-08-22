import 'package:http/http.dart' as http;
import 'dart:convert';


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

void main() async{
  try {
    final data = await getJsonResponse('https://jsonplaceholder.typicode.com/posts/1');
    print(data);
  } catch (e) {
    print('No se pudo obtener los datos del post: $e');
  }
}