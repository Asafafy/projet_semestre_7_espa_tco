import 'package:Ordonnances/services/servicesFirestoreMedicaments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../couleurs/couleurs.dart';
import '../../../models/modeleMedicaments.dart';
import '../../../models/modeleOrdonnanceMedicale.dart';
import '../listeOrdonnances.dart';

class AjouterMedicaments extends StatefulWidget {
  User patient;
  ModeleOrdonnanceMedicale ordonnance;
  ModeleMedicament? medicaments;

  AjouterMedicaments(this.patient, this.ordonnance, this.medicaments);

  @override
  State<AjouterMedicaments> createState() => _AjouterMedicamentsState();
}

class _AjouterMedicamentsState extends State<AjouterMedicaments> {
  TextEditingController controlleurNomMedicament = TextEditingController();
  TextEditingController controlleurMatin = TextEditingController();
  TextEditingController controlleurMidi = TextEditingController();
  TextEditingController controlleurSoir = TextEditingController();
  TextEditingController controlleurMinuit = TextEditingController();
  TextEditingController controlleurJourPrise = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter Médicaments"),
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
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                elevation: 5,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Nom du médicament",
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        controller: controlleurNomMedicament,
                        decoration: const InputDecoration(
                          label: Text(
                            "exemple Nom Médicament",
                            style: TextStyle(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Matin",
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextField(
                                  controller: controlleurMatin,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Quantité Prise",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Midi",
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextField(
                                  controller: controlleurMidi,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Quantité Prise",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Soir",
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextField(
                                  controller: controlleurSoir,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Quantité Prise",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                "Minuit",
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextField(
                                  controller: controlleurMinuit,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Quantité Prise",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Durrée de la prise (en jour)",
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        controller: controlleurJourPrise,
                        decoration: const InputDecoration(
                          label: Text(
                            "xx jours (nombre)",
                            style: TextStyle(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      child: const Text(
                        "Enregistrer",
                        style: TextStyle(
                            fontSize: 20,
                            color: CouleursApplications.textesAppBar),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CouleursApplications
                            .appBarVert, // Set background color here
                      ),
                      onPressed: () async {
                        if (controlleurNomMedicament.text == "" ||
                            controlleurMatin.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Tous les champs sont requis !"),
                            backgroundColor: Colors.red,
                          ));
                        } else if (controlleurMidi.text == "" ||
                            controlleurSoir.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Tous les champs sont requis !"),
                            backgroundColor: Colors.red,
                          ));
                        } else if (controlleurMinuit.text == "" ||
                            controlleurJourPrise.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Tous les champs sont requis !"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          await ServicesFirestoreMedicaments()
                              .insererMedicament(
                                  widget.ordonnance.id,
                                  controlleurMatin.text,
                                  controlleurMidi.text,
                                  controlleurSoir.text,
                                  controlleurMinuit.text,
                                  controlleurNomMedicament.text,
                                  controlleurJourPrise.text);
                          ModeleMedicament medicamentAJour = ModeleMedicament(
                              idOrdonnance: widget.ordonnance.id,
                              nomMedicament: controlleurNomMedicament.text,
                              matin: controlleurMatin.text,
                              midi: controlleurMidi.text,
                              soir: controlleurSoir.text,
                              minuit: controlleurMinuit.text,
                              nbrJour: controlleurJourPrise.text);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ListeOrdonnances(widget.patient)),
                              (route) => false);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
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
