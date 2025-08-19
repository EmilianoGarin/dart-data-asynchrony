import 'dart:convert';
import 'dart:io';

void readLogFile() async {
  String direcionArchivo = "storage/data.txt";

  try {
    
    File archivo = File(direcionArchivo);

    if (!await archivo.exists()) {
      print("El archivo no existe.");
      return;
    }
    
    List<String> lineas = await archivo.readAsLines(encoding: utf8);
    
    List<String> lineasConComillas = lineas.map((linea) => '"$linea"').toList();

    print(lineasConComillas);

  } on PathNotFoundException catch (e) {
    print("Error: La ruta especificada no es válida. $e");
  } on FileSystemException catch (e) {
    print("Error: No se pudo acceder o escribir en el archivo/carpeta. $e");
  } catch (e) {
    print("Ocurrió un error inesperado: $e");
  }
}

void main() {
  readLogFile();
}