import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/accueil.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/s_inscrire.dart';

import '../services/servicesAuthentifications.dart';

class SeConnecter extends StatefulWidget {
  @override
  State<SeConnecter> createState() => _SeConnecterState();
}

class _SeConnecterState extends State<SeConnecter> {
  TextEditingController controlleurEmail = TextEditingController();
  TextEditingController controlleurMotDePasse = TextEditingController();

  bool chargement = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Se connecter"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
      ),
      body: ListView(
        children: [
          SizedBox(height: 120.0,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
            child: TextField(
              controller: controlleurEmail,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscuringCharacter: "*",
              obscureText: true,
              controller: controlleurMotDePasse,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 50.0,),
          chargement ? LinearProgressIndicator() : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Text("Envoyer", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                onPressed: () async {
                  setState(() {
                    chargement = true;
                  });
                  if (controlleurEmail.text == ""  || controlleurMotDePasse.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis !"), backgroundColor: Colors.red,));
                  } else {
                    User? resultat = await ServicesAuthentifications().seConnecter(controlleurEmail.text, controlleurMotDePasse.text, context);
                    if (resultat != null) {
                      print("Connexion avec succès");
                      print(resultat.email);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Accueil()), (route) => false);
                    }
                  }
                  setState(() {
                    chargement = false;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SInscrire()));
            },
            child: Text("Vous n'avez pas de compte? Créez-en un")
          ),
        ],
      ),
    );
  }
}
