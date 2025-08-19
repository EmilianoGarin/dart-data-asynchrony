import 'dart:io';

void initializeLogFile() async{
  String direcionCarpeta = "storage/";
  String direcionArchivo = "data.txt";
  String texto   = "User activity log initialized";

  try {
    Directory carpeta = Directory(direcionCarpeta);
    
    if (!await carpeta.exists()) {
      await carpeta.create(recursive: true);
    }

    File archivo = File(direcionCarpeta + direcionArchivo);

    if (!await archivo.exists()) {
      await archivo.create();
    }

    await archivo.writeAsString(texto);
  } on PathNotFoundException catch (e) {
    print("Error: La ruta especificada no es válida. $e");
  } on FileSystemException catch (e) {
    print("Error: No se pudo acceder o escribir en el archivo/carpeta. $e");
  } catch (e) {
    print("Ocurrió un error inesperado: $e");
  }
  print("El archivo $direcionArchivo se inicializó correctamente.");
}

void main() {
  initializeLogFile();
}