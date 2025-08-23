Future<String> simApi(Duration duration, String text) async {
  return await Future.delayed(duration, () {return text;});
}

Future<List<String>> runParallelCalls() async {
  //Stopwatch stopwatch = Stopwatch()..start(); // Crea e inicia el cronómetro

  List<Future<String>> texts = [ simApi(Duration(seconds: 1), "First"),
                                 simApi(Duration(seconds: 2), "Second"),
                                 simApi(Duration(seconds: 3), "Third")];
  
  List<String> results = await Future.wait(texts);

  //stopwatch.stop(); // Detiene el cronómetro
  //print("Tiempo de ejecución: ${stopwatch.elapsedMilliseconds} ms");

  return results;
}

void main(List<String> args) {
  runParallelCalls().then((results) {
    print(results);
  });
}