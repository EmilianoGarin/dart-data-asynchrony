import 'dart:math';

Future<String> safeNetworkCall() async {
  await Future.delayed(Duration(seconds: 2));
  int rand = Random().nextInt(10);
  if (rand % 2 == 0){
    throw Exception("Network error");
  }
  return "Data received";
}

void main(List<String> args) async {
  try {
    String data = await safeNetworkCall();
    print(data);
  } catch (e) {
    if (e is Exception && e.toString().contains("Network error")) { // Verifica si es una Exception y contiene el mensaje deseado
      print("Fallback data");
    }
  }
}