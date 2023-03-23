import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/listeOrdonnances.dart';
import 'package:projet_semestre_7_espa_tco/services/authentificationPatients.dart';

import 'ecrans/authentificationsUtilisateurs/se_connecter.dart';

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
      debugShowCheckedModeBanner: false,
      title: "Projet Semestre 7 ESPA TCO",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: StreamBuilder(
        stream: ServicesAuthentifications().firebaseAuth.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListeOrdonnances(snapshot.data);
          } else {
            return SeConnecter();
          }
        },
      ),
    );
  }
}