Future<String> multiStepProcess() async {
  await Future.delayed(Duration(seconds: 1), () {print("1. Waits 1 second and prints `\"Step 1\"`.");});
  await Future.delayed(Duration(seconds: 1), () {print("2. Waits another second and prints `\"Step 2\"`.");});
  return await Future.delayed(Duration(seconds: 1), () { return "Done";});
}

void main(List<String> args) async {
  String data = await multiStepProcess();
  print("3. Returns `\"$data\"`.");
}