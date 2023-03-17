import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/se_connecter.dart';
import 'package:projet_semestre_7_espa_tco/services/servicesAuthentifications.dart';

class SInscrire extends StatefulWidget {
  @override
  State<SInscrire> createState() => _SInscrireState();
}

class _SInscrireState extends State<SInscrire> {
  TextEditingController controlleurEmail = TextEditingController();
  TextEditingController controlleurMotDePasse = TextEditingController();
  TextEditingController controlleurConfirmationMdp = TextEditingController();

  bool chargement = false;


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
          SizedBox(height: 100.0,),
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
                  } else if (controlleurMotDePasse.text != controlleurConfirmationMdp.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Les mots de passe ne correspondent pas"), backgroundColor: Colors.red,));
                  } else {
                    User? resultat = await ServicesAuthentifications().sInscrire(controlleurEmail.text, controlleurMotDePasse.text, context);
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
