import 'dart:io';

void appendLogEntry() async {
  String direcionArchivo = "storage/data.txt";

  String fecha = DateTime.now().toIso8601String();

  try {
    File archivo = File(direcionArchivo);

    if (!await archivo.exists()) {
      await archivo.create();
    }

    // de base esta linea permite crear el archivo si no existe
    // el FileMode.append le indica que agrege de lo contrario sobre escribe el contenido
    await archivo.writeAsString("\n$fecha", mode: FileMode.append);


  } on PathNotFoundException catch (e) {
    print("Error: La ruta especificada no es válida. $e");
  } on FileSystemException catch (e) {
    print("Error: No se pudo acceder o escribir en el archivo/carpeta. $e");
  } catch (e) {
    print("Ocurrió un error inesperado: $e");
  }
  print("Se fecho con exito");
}

void main() {
  appendLogEntry();
}