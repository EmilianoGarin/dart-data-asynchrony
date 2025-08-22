import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> fetchPostTitles() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  try {
      final response = await http.get(url);

      if (response.statusCode == 200) {

        List<dynamic> data = json.decode(response.body);
        List<String> titles = [];
        while (data.isNotEmpty && titles.length <= 100){
         titles.add(data.removeAt(0)['title']);
        }
        return titles;
      } else {
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

void main() {
  fetchPostTitles().then((titles) { // Espero a que la función retorne la lista
    print(titles);
  });
}