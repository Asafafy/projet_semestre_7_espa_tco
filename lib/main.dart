import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/accueil.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/se_connecter.dart';
import 'package:projet_semestre_7_espa_tco/services/servicesAuthentifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Projet Semestre 7 ESPA TCO",
      home: StreamBuilder(
        stream: ServicesAuthentifications().firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Accueil();
          } else {
            return SeConnecter();
          }
        },
      ),
    );
  }
}