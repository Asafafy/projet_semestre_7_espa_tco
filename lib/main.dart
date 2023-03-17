import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/accueil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Projet Semestre 7 ESPA TCO",
      home: Accueil(),
    );
  }
}