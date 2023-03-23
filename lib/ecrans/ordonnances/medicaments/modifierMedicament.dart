import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/modeleMedicaments.dart';
import '../../../models/modeleOrdonnanceMedicale.dart';
import '../../../services/servicesFirestoreMedicaments.dart';
import '../modifierOrdonnance.dart';


class ModifierMedicaments extends StatefulWidget {
  User patient;
  ModeleOrdonnanceMedicale ordonnance;
  ModeleMedicament medicament;
  ModifierMedicaments(this.ordonnance, this.patient, this.medicament);

  @override
  State<ModifierMedicaments> createState() => _ModifierMedicamentsState();
}

class _ModifierMedicamentsState extends State<ModifierMedicaments> {
  TextEditingController controlleurNomMedicament = TextEditingController();
  TextEditingController controlleurMatin = TextEditingController();
  TextEditingController controlleurMidi = TextEditingController();
  TextEditingController controlleurSoir = TextEditingController();
  TextEditingController controlleurMinuit = TextEditingController();
  TextEditingController controlleurJourPrise = TextEditingController();

  @override
  void initState() {
    controlleurNomMedicament.text = widget.medicament.nomMedicament;
    controlleurMatin.text = widget.medicament.matin;
    controlleurMidi.text = widget.medicament.midi;
    controlleurSoir.text = widget.medicament.soir;
    controlleurMinuit.text = widget.medicament.minuit;
    controlleurJourPrise.text = widget.medicament.nbrJour;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier des Médicaments"),
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
                  await ServicesFirestoreMedicaments().mettreAJour(
                      widget.medicament.idOrdonnance,
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
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ModifierOrdonnance(widget.ordonnance, widget.patient, medicamentAJour)), (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
