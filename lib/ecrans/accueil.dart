import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
      ),
    );
  }
}
