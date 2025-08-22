import 'package:http/http.dart' as http;
import 'dart:convert';

 Future<int> sendPost() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final Map<String, dynamic> postData = {
    'title': 'Nuevo Post',
    'body': 'Contenido del post',
    'userId': 1,
  };

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, // Indica que estás enviando JSON
      body: json.encode(postData),
    );

    if (response.statusCode == 201) {
      // La solicitud fue exitosa y se creó un recurso (código 201)
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final int postId = responseData['id'];
      return postId; // Retorna el ID del nuevo post
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

void main() async {
  try {
    final postId = await sendPost();
    print('ID del nuevo post: $postId');
    print("101");
  } catch (e) {
    print('No se pudo obtener el ID del nuevo post: $e');
  }
}