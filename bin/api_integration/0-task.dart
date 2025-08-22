import 'package:http/http.dart' as http;
import 'dart:convert'; // Necesario para decodificar JSON

Future<Map<String, String>> fetchPost() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodifica el JSON
      Map<String, dynamic> data = json.decode(response.body);
      
      Map<String, String> info = {
        'title': data['title'],
        'body': data['body'],
      };
      return info;
    }  else {
      // Hubo un error, puedes lanzar una excepción o retornar un mapa vacío o con información de error
      print('Error en la solicitud: ${response.statusCode}');
      throw Exception('Error al obtener datos de la API: ${response.statusCode}'); // Lanzo una excepción
    }
  } catch (e) {
    // Manejo de errores de conexión o http
    print('Ocurrió un error: $e');
    throw Exception('Ocurrió un error al procesar la solicitud: $e'); // Lanzo una excepción
  }
}


void main() async { // main también debe ser async para poder usar await
  try {
    final postData = await fetchPost(); // Espero a que la función retorne el mapa
    print(postData);
  } catch (e) {
    print('No se pudo obtener los datos del post: $e');
  }
}