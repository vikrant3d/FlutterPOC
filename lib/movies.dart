import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movies extends StatelessWidget {
  Movies({Key? key}) : super(key: key) {
    subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Movies",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)));
  }

  subscribe() async {
    print("Subscribing..");
    try {
      http.Client _client = http.Client();

      var request = http.Request(
          "POST",
          Uri.parse(
              "https://cjp3tzoru4.execute-api.ap-south-1.amazonaws.com/dev/C/C/getofferNote"));

      Future<http.StreamedResponse> response = _client.send(request);

      response.asStream().listen((streamedResponse) {
        print(
            "Received streamedResponse.statusCode:${streamedResponse.statusCode}");
        streamedResponse.stream.listen((data) {
          print("Received data:$data");
        });
      });
    } catch (e) {
      print("Caught $e");
    }
  }
}
