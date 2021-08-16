import 'package:flutter/material.dart';

class Books extends StatelessWidget {
  const Books({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Books",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)));
  }
}
