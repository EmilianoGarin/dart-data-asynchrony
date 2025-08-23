Stream<int> emitWithDelay(List<int> values) async*{
  for (int value in values){
    yield value;
    await Future.delayed(Duration(milliseconds: 500));
  }
}

void main(List<String> args) {
  
  List<int> myValues = [10, 20, 30, 40, 50];

  emitWithDelay(myValues).listen(
    (number) {
      print("Número de la lista recibido: $number");
    },
    onDone: () {
      print("Todos los números de la lista han sido emitidos.");
    },
    onError: (error) {
      print("Error: $error");
    },
  );
}