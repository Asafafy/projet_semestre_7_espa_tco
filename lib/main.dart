import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projet_semestre_7_espa_tco/ecranChargement.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/listeOrdonnances.dart';
import 'package:projet_semestre_7_espa_tco/services/authentificationPatients.dart';
import 'ecrans/authentificationsUtilisateurs/se_connecter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<void> _chargerDonnees() async {
    await Future.delayed(Duration(seconds: 3));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _chargerDonnees(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
          } else {
            return EcranChargement();
          }
        }
    );
  }
}