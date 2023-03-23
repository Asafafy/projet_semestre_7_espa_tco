import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/authentificationDocteur.dart';



class ConnexionDocteur extends StatefulWidget {
  User patient;
  Timestamp? dateOrdonnanceMedicale;
  bool estEdition;
  ConnexionDocteur(this.patient, this.dateOrdonnanceMedicale, this.estEdition);

  @override
  State<ConnexionDocteur> createState() => _ConnexionDocteurState();
}

class _ConnexionDocteurState extends State<ConnexionDocteur> {
  TextEditingController controlleurNomDocteur = TextEditingController();
  TextEditingController controlleurMotDePasseDocteur = TextEditingController();

  bool chargement = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentification du Docteur"),
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
              controller: controlleurNomDocteur,
              decoration: InputDecoration(
                labelText: "Nom du docteur",
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
              controller: controlleurMotDePasseDocteur,
              decoration: InputDecoration(
                labelText: "Mot de passe du docteur",
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
                  if (controlleurNomDocteur.text == ""  || controlleurMotDePasseDocteur.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis !"), backgroundColor: Colors.red,));
                  } else {
                    await AuthentificationDocteur().seConnecterDocteur(controlleurNomDocteur.text, controlleurMotDePasseDocteur.text, widget.patient, widget.estEdition, widget.dateOrdonnanceMedicale, context);
                  }
                  setState(() {
                    chargement = false;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info, color: Colors.green,),
              Text("  Contactez le responsable pour avoir un compte docteur", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green)),
            ],
          )
        ],
      ),
    );
  }
}
