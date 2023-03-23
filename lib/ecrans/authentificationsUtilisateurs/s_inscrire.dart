import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/authentificationsUtilisateurs/se_connecter.dart';

import 'package:projet_semestre_7_espa_tco/services/authentificationPatients.dart';

class SInscrire extends StatefulWidget {
  @override
  State<SInscrire> createState() => _SInscrireState();
}

class _SInscrireState extends State<SInscrire> {
  TextEditingController controlleurNom = TextEditingController();
  TextEditingController controlleurEmail = TextEditingController();
  TextEditingController controlleurMotDePasse = TextEditingController();
  TextEditingController controlleurConfirmationMdp = TextEditingController();

  bool chargement = false;
  bool valCheckbox = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("S'inscrire"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
      ),
      body: ListView(
        children: [
          SizedBox(height: 50.0,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
            child: TextField(
              controller: controlleurNom,
              decoration: InputDecoration(
                labelText: "Nom",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscuringCharacter: "*",
              obscureText: true,
              controller: controlleurConfirmationMdp,
              decoration: InputDecoration(
                labelText: "Confirmation du mot de passe",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          CheckboxListTile(
            value: valCheckbox,
            title: Text("Docteur"),
            onChanged: (val) {
              setState(() {
                valCheckbox = val!;
              });
            },
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
                  User? resultat;
                  if (controlleurEmail.text == ""  || controlleurMotDePasse.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis !"), backgroundColor: Colors.red,));
                  } else if (controlleurMotDePasse.text != controlleurConfirmationMdp.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Les mots de passe ne correspondent pas"), backgroundColor: Colors.red,));
                  } else {
                    var contenuTexte;
                    if (valCheckbox) {
                      contenuTexte = Text("Voulez-vous créer le compte en tant que medecin ?");
                    } else {
                      contenuTexte = Text("Voulez-vous créer le compte en tant que patient ?");
                    }
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(controlleurNom.text),
                          content: contenuTexte,
                          actions: [
                            TextButton(
                              onPressed: () async {
                                User? resultat = await ServicesAuthentifications().sInscrire(controlleurNom.text, controlleurEmail.text, controlleurMotDePasse.text, valCheckbox, context);
                                Navigator.pop(context);
                              },
                              child: Text("Oui"),
                            ),
                            TextButton(
                              onPressed: () {Navigator.pop(context);},
                              child: Text("Non"),
                            ),
                          ],
                        );
                      }
                    );




                    if (resultat != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Compte créé avec succès, Veuillez vous connecter"),
                        backgroundColor: Colors.greenAccent,)
                      );
                      print("Création de compte effectuée avec succès");
                      print(resultat.email);
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SeConnecter()));
            },
            child: Text("Avez-vous déjà un compte? Connectez-vous ici")
          ),
        ],
      ),
    );
  }
}
