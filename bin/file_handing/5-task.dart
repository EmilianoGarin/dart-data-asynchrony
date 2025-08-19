import 'dart:io';

Future<bool> deleteLogFileIfExists() async {
  String direcionArchivo = "storage/data.txt";

  try{
    File archivo = File(direcionArchivo);

    if (await archivo.exists()) {
      await archivo.delete();
      return true;
    } else {
      return false;
    }

  }on PathNotFoundException catch (e) {
    print("Error: La ruta especificada no es válida. $e");
  } on FileSystemException catch (e) {
    print("Error: No se pudo acceder o escribir en el archivo/carpeta. $e");
  } catch (e) {
    print("Ocurrió un error inesperado: $e");
  }
  return false;
}
void main() async {
  if ( await deleteLogFileIfExists()){
    print("El archivo se eliminó correctamente.");
  }else{
    print("El archivo no existe.");
  }
}