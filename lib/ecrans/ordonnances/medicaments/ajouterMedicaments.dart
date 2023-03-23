import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/listeOrdonnances.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/medicaments/listeMedicaments.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/modifierOrdonnance.dart';
import 'package:projet_semestre_7_espa_tco/services/servicesFirestoreMedicaments.dart';

import '../../../models/modeleMedicaments.dart';
import '../../../models/modeleOrdonnanceMedicale.dart';


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
        title: Text("Ajouter des Médicaments"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Text("Nom du médicament",),
            SizedBox(height: 5.0,),
            TextField(
              controller: controlleurNomMedicament,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Matin",),
            SizedBox(height: 5.0,),
            TextField(
              controller: controlleurMatin,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Midi",),
            SizedBox(height: 5.0,),
            TextField(
              controller: controlleurMidi,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Soir",),
            SizedBox(height: 5.0,),
            TextField(
              controller: controlleurSoir,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Minuit",),
            SizedBox(height: 5.0,),
            TextField(
              controller: controlleurMinuit,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("Durrée de la prise (en jour)",),
            SizedBox(height: 5.0,),
            TextField(
              controller: controlleurJourPrise,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50.0,),
            ElevatedButton(
              child: Text("Valider"),
              onPressed: () async {
                if (controlleurNomMedicament.text == ""  || controlleurMatin.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis !"), backgroundColor: Colors.red,));
                } else if (controlleurMidi.text == ""  || controlleurSoir.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis !"), backgroundColor: Colors.red,));
                } else if (controlleurMinuit.text == ""  || controlleurJourPrise.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis !"), backgroundColor: Colors.red,));
                } else {
                  await ServicesFirestoreMedicaments().insererMedicament(
                      widget.ordonnance.id,
                      controlleurMatin.text,
                      controlleurMidi.text,
                      controlleurSoir.text,
                      controlleurMinuit.text,
                      controlleurNomMedicament.text,
                      controlleurJourPrise.text
                  );
                  ModeleMedicament medicamentAJour = ModeleMedicament(
                      idOrdonnance: widget.ordonnance.id,
                      nomMedicament: controlleurNomMedicament.text,
                      matin: controlleurMatin.text,
                      midi: controlleurMidi.text,
                      soir: controlleurSoir.text,
                      minuit: controlleurMinuit.text,
                      nbrJour: controlleurJourPrise.text
                  );
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ListeOrdonnances(widget.patient)), (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
