import 'package:Ordonnances/ecrans/ordonnances/listeOrdonnances.dart';
import 'package:Ordonnances/models/docteur.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../couleurs/couleurs.dart';
import '../../services/servicesFirestoreOrdonnance.dart';

class AjouterOrdonnance extends StatefulWidget {
  User patient;
  ModeleDocteur docteur;

  AjouterOrdonnance(this.patient, this.docteur);

  @override
  State<AjouterOrdonnance> createState() => _AjouterOrdonnanceState();
}

class _AjouterOrdonnanceState extends State<AjouterOrdonnance> {
  TextEditingController controlleurMaladie = TextEditingController();
  TextEditingController controlleurDescriptionsMaladie =
      TextEditingController();

  bool chargement = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter ordonnance médicale"),
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
              child: const Image(
                image: AssetImage('images/header-ordonnance-medicale.png'),
              ),
            ),
            const SizedBox(height: 40.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                elevation: 5,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "MALADIES",
                        style: TextStyle(
                          color: CouleursApplications.appBarVert,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        minLines: 2,
                        maxLines: 5,
                        controller: controlleurMaladie,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "DESCRIPTIONS",
                        style: TextStyle(
                          color: CouleursApplications.appBarVert,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        controller: controlleurDescriptionsMaladie,
                        minLines: 6,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    chargement
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                child: const Text("Créer l'ordonnance", style: TextStyle(fontSize: 20, color: CouleursApplications.textesAppBar),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CouleursApplications.appBarVert, // Set background color here
                                ),
                                onPressed: () async {
                                  if (controlleurMaladie.text == "" ||
                                      controlleurDescriptionsMaladie == "") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Tous les champs sont requis"),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    setState(() {
                                      chargement = true;
                                    });
                                    await ServicesFirestoreOrdonnances()
                                        .insererOrdonnance(
                                            controlleurMaladie.text,
                                            controlleurDescriptionsMaladie.text,
                                            widget.patient.uid,
                                            widget.docteur.id);
                                    setState(() {
                                      chargement = false;
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListeOrdonnances(
                                                      widget.patient)),
                                          (route) =>
                                              false); //Revenir sur l'écran "Liste Ordonnances"
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
