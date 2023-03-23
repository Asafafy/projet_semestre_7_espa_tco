import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../couleurs/couleurs.dart';
import '../../services/authentificationPatients.dart';
import 'se_connecter.dart';

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
        title: const Text("S'inscrire"),
        centerTitle: true,
        backgroundColor: CouleursApplications.appBarVert,
        foregroundColor: CouleursApplications.textesAppBar,
      ),
      body: ListView(
        children: [
          Container(
            color: CouleursApplications.appBarVert,
            child: const Image(
              image: AssetImage('images/banniere-ordonnance-medicale.png'),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 30.0, right: 20.0),
                    child: TextField(
                      controller: controlleurNom,
                      decoration: const InputDecoration(
                        labelText: "Nom",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextField(
                      controller: controlleurEmail,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      obscuringCharacter: "*",
                      obscureText: true,
                      controller: controlleurMotDePasse,
                      decoration: const InputDecoration(
                        labelText: "Mot de passe",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      obscuringCharacter: "*",
                      obscureText: true,
                      controller: controlleurConfirmationMdp,
                      decoration: const InputDecoration(
                        labelText: "Confirmation du mot de passe",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                    value: valCheckbox,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Docteur"),
                    onChanged: (val) {
                      setState(() {
                        valCheckbox = val!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  chargement
                      ? const LinearProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CouleursApplications.appBarVert, // Set background color here
                              ),
                              child: const Text(
                                "Envoyer",
                                style: TextStyle(
                                    fontSize: 20.0),
                              ),
                              onPressed: () async {
                                setState(() {
                                  chargement = true;
                                });
                                User? resultat;
                                if (controlleurEmail.text == "" ||
                                    controlleurMotDePasse.text == "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text("Tous les champs sont requis !"),
                                    backgroundColor: Colors.red,
                                  ));
                                } else if (controlleurMotDePasse.text !=
                                    controlleurConfirmationMdp.text) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Les mots de passe ne correspondent pas"),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  var contenuTexte;
                                  if (valCheckbox) {
                                    contenuTexte = const Text(
                                        "Voulez-vous créer le compte en tant que medecin ?");
                                  } else {
                                    contenuTexte = const Text(
                                        "Voulez-vous créer le compte en tant que patient ?");
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
                                                User? resultat =
                                                    await ServicesAuthentifications()
                                                        .sInscrire(
                                                            controlleurNom.text,
                                                            controlleurEmail
                                                                .text,
                                                            controlleurMotDePasse
                                                                .text,
                                                            valCheckbox,
                                                            context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Oui"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Non"),
                                            ),
                                          ],
                                        );
                                      });
                                  if (resultat != null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Compte créé avec succès, Veuillez vous connecter"),
                                      backgroundColor: Colors.greenAccent,
                                    ));
                                  }
                                }
                                setState(() {
                                  chargement = false;
                                });
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SeConnecter()));
              },
              child: const Text("Avez-vous déjà un compte? Connectez-vous ici")),
        ],
      ),
    );
  }
}
