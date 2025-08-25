import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'note.dart'; 

// recupera las notas del archivo local notes.json
Future<List<Note>> readNotesFromFile() async {
  final String direcionArchivo = "storage/notes.json";
  List<Note> notes = [];

  try {
    // Leer el contenido del archivo
    final File archivo = File(direcionArchivo);

    if (await archivo.exists()) {
      // Leer el contenido del archivo
      String notasCodificada = await archivo.readAsString(encoding: utf8);
      // Decodificar el contenido del archivo

      notes = (jsonDecode(notasCodificada) as List).map((json) => Note.fromJson(json)).toList();
    }else{
      print("El archivo no existe.");
    }
    return notes;

  } on PathNotFoundException catch (e) {
    print("readNotesFromFile() Error: La ruta especificada no es válida. $e");
  } on FileSystemException catch (e) {
    print("readNotesFromFile() Error: No se pudo acceder o escribir en el archivo/carpeta. $e");
  } catch (e) {
    print("readNotesFromFile() Ocurrió un error inesperado: $e");
  }
  
  return notes;
}
// recupera las notas de la API
Future<List<Note>> readNotesFromHttp() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  List<Note> notes = [];

  try {
    // Realizar la solicitud GET a la API
    final response = await http.get(url);
    // Verificar el código de estado de la respuesta
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      notes = data.map((json) => Note.fromJson(json)).toList();
    } else {
      print('Error al obtener datos de la API: ${response.statusCode}');
    }

    return notes;

  } on PathNotFoundException catch (e) {
    print("readNotesFromHttp() Error: La ruta especificada no es válida. $e");
  } on FileSystemException catch (e) {
    print("readNotesFromHttp() Error: No se pudo acceder o escribir en el archivo/carpeta. $e");
  } catch (e) {
    print("readNotesFromHttp() Ocurrió un error inesperado: $e");
  }
  return notes;
}
// carga las notas en el archivo local notes.json y crea la carpeta storage si no existe
void initNotesFile(List<Note> notes) async{
  String direcionCarpeta = "storage/";
  String direcionArchivo = "notes.json";
  String notesEncode = jsonEncode(notes);

  try {
    Directory carpeta = Directory(direcionCarpeta);
    
    if (!await carpeta.exists()) {
      await carpeta.create(recursive: true);
    }

    File archivo = File(direcionCarpeta + direcionArchivo);

    if (!await archivo.exists()) {
      await archivo.create();
    }

    await archivo.writeAsString(notesEncode);

  } on PathNotFoundException catch (e) {
    print("initNotesFile() Error: La ruta especificada no es válida. $e");
  } on FileSystemException catch (e) {
    print("initNotesFile() Error: No se pudo acceder o escribir en el archivo/carpeta. $e");
  } catch (e) {
    print("initNotesFile() Ocurrió un error inesperado: $e");
  }

}
// crea las notas en la API
void postNotesFile(List<Note> notes) async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  try {
    int idLastNote = (await readNotesFromHttp()).last.id;

    for (Note note in notes) {
      if (note.id > idLastNote) {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(note.toJson()),
        );

        if (response.statusCode != 201) {
          print('Error al crear la nota: ${response.statusCode}');
        } 
      } 
    }
  
  } catch (e) {
    print('postNotesFile() Ocurrió un error: $e');
  }


}

Stream<Note> streamNotes(List<Note> notes) async* {
  for (Note note in notes.reversed){
    yield note;
    await Future.delayed(Duration(seconds: 1));
  }
}

void printNotes(Stream<Note> stream, int n) {
  
  stream.take(n).listen(
    (note) {
      print("ID: ${note.id} \nFecha de Creación: ${note.createdAt} \nTítulo: ${note.title} \nCuerpo: ${note.body}");
    },
    onDone: () {
      print("Todas las notas han sido emitidas.");
    },
    onError: (error) {
      print("Error: $error");
    },
  );
}

void main() async {
  List<Note> notesHttp = await readNotesFromHttp();
  List<Note> notesFile = await readNotesFromFile();
  
  int idLastNote = 0;
  if (notesHttp.isNotEmpty) idLastNote = notesHttp.last.id;
  // Filtrar notesFile para obtener solo las notas con ID mayor que idLastNote
  List<Note> newNotesFile = notesFile.where((note) => note.id > idLastNote).toList();
  // Combinar las notas de notesHttp y newNotesFile
  List<Note> notes = [...notesHttp, ...newNotesFile];


  String? comand;
  try {
    do {
    stdout.write("Crear una nota nueva (si/no):");
    comand = stdin.readLineSync()!;
    if (comand == "si") {
      int id = notes.isEmpty ? 1 : notes.last.id + 1;

      stdout.write("Ingrese el título de la nota: ");
      String title = stdin.readLineSync()!;

      stdout.write("Ingrese el cuerpo de la nota: ");
      String body = stdin.readLineSync()!;

      String createdAt = DateTime.now().toString();

      Note newNote = Note(id, title, body, createdAt);
      notes.add(newNote);
      notesFile.add(newNote);
    }
  } while (comand != "no");

  stdout.write("Quiere ver las notas en orden inverso? (si/no):");
  comand = stdin.readLineSync()!;
  if (comand == "si") {
    stdout.write("Cuantas? (indique un número positivo):");
    comand = stdin.readLineSync()!;
    if (comand.isNotEmpty && int.tryParse(comand) != null && int.parse(comand) > 0 && int.parse(comand) <= notes.length) {
    printNotes(streamNotes(notes), int.parse(comand));
    } else
    { 
      print("El número ingresado no es válido.\n Fin");
    }
  }
  
  initNotesFile(notesFile);
  print("Notas guardadas en el archivo notes.json");
  postNotesFile(notesFile);
  print("Notas enviadas a la API");

  } catch (e) {
    print('Ocurrió un error: $e');
  }
}
