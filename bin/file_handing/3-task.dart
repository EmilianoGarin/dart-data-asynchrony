import 'dart:io';

void listStorageFiles() async {
  String direcionCarpeta = "storage/";

  try{
    Directory carpeta = Directory(direcionCarpeta);

    if (!await carpeta.exists()) {
      print("La carpeta no existe.");
      return;
    }

    Stream<FileSystemEntity> contenido = await carpeta.list();
    List<String> archivos = [];

    await for (FileSystemEntity archivo in contenido) {
      if (archivo is File) {
        archivos.add(archivo.path.split("/").last);
      }
    }

    List<String> archivosConComillas = archivos.map((archivo) => '"$archivo"').toList();

    print(archivosConComillas);
    
  } on PathNotFoundException catch (e) {
    print("Error: La ruta especificada no es válida. $e");
  } on FileSystemException catch (e) {
    print("Error: No se pudo acceder o escribir en el archivo/carpeta. $e");
  } catch (e) {
    print("Ocurrió un error inesperado: $e");
  }
}

void main() {
  listStorageFiles();
}