import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/couleurs/couleurs.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/listeOrdonnances.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/authentificationsUtilisateurs/s_inscrire.dart';
import '../../services/authentificationPatients.dart';


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
        backgroundColor: CouleursApplications.appBarVert,
        foregroundColor: CouleursApplications.textesAppBar,
      ),
      body: Container(
        color: CouleursApplications.fondApplication,
        child: ListView(
          children: [
            Container(
              color: CouleursApplications.appBarVert,
              child: Image(
                image: AssetImage('images/banniere-ordonnance-medicale.png'),
              ),
            ),
            SizedBox(height: 50.0,),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                elevation: 5,
                child: Column(
                  children: [
                    SizedBox(height: 30.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CouleursApplications.appBarVert, // Set background color here
                          ),
                          child: Text("Envoyer", style: TextStyle(fontSize: 20, color: CouleursApplications.textesAppBar),),
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
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ListeOrdonnances(resultat)), (route) => false);
                              }
                            }
                            setState(() {
                              chargement = false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
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
      ),
    );
  }
}
