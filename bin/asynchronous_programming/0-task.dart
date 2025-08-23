Future<String> simulateNetworkCall() async {
  return await Future.delayed(Duration(seconds: 2), () { return "Data received";});
}

void main(List<String> args) async {
  String data = await simulateNetworkCall();
  print(data);
}