import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../couleurs/couleurs.dart';
import '../../models/modeleMedicaments.dart';
import '../../models/modeleOrdonnanceMedicale.dart';
import '../../services/servicesFirestoreOrdonnance.dart';
import 'listeOrdonnances.dart';
import 'medicaments/listeMedicaments.dart';

class ModifierOrdonnance extends StatefulWidget {
  User patient;
  ModeleOrdonnanceMedicale ordonnance;
  ModeleMedicament? medicament;

  ModifierOrdonnance(this.ordonnance, this.patient, this.medicament);

  @override
  State<ModifierOrdonnance> createState() => _ModifierOrdonnanceState();
}

class _ModifierOrdonnanceState extends State<ModifierOrdonnance> {
  TextEditingController controlleurMaladie = TextEditingController();
  TextEditingController controlleurDescriptionsMaladie =
      TextEditingController();
  bool chargement = false;

  @override
  void initState() {
    controlleurMaladie.text = widget.ordonnance.maladie;
    controlleurDescriptionsMaladie.text = widget.ordonnance.descriptionsMaladie;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier des notes"),
        centerTitle: true,
        backgroundColor: CouleursApplications.appBarVert,
        foregroundColor: CouleursApplications.textesAppBar,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirmation de la suppresion"),
                    content: const Text(
                        "Êtes-vous sûr de vouloir supprimer cette ordonnance ?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await ServicesFirestoreOrdonnances()
                              .supprimmerOrdonnance(widget.ordonnance.id);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ListeOrdonnances(widget.patient)),
                              (route) => false);
                        },
                        child: const Text("Oui"),
                      ),
                      TextButton(
                        child: const Text("Non"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
              color: CouleursApplications.textesAppBar,
            ),
          ),
        ],
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
                height: 40.0,
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
                        height: 20.0,
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
                        height: 30.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: const Text(
                            "Liste des medicaments",
                            style: TextStyle(
                                fontSize: 20,
                                color: CouleursApplications.textesAppBar),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CouleursApplications.fondListTile, // Set background color here
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListeMedicaments(
                                        widget.patient, widget.ordonnance)));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      chargement
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                child: const Text(
                                  "Mettre à jour",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: CouleursApplications.textesAppBar),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CouleursApplications
                                      .appBarVert, // Set background color here
                                ),
                                onPressed: () async {
                                  if (controlleurMaladie.text == "" ||
                                      controlleurDescriptionsMaladie.text ==
                                          "") {
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
                                        .mettreAJourOrdonnance(
                                            widget.ordonnance.id,
                                            controlleurMaladie.text,
                                            controlleurDescriptionsMaladie
                                                .text);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ListeOrdonnances(
                                                    widget.patient)),
                                        (route) => false);
                                    setState(() {
                                      chargement = false;
                                    });
                                  }
                                },
                              ),
                            ),
                      const SizedBox(height: 30,),
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
