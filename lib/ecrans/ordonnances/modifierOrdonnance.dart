import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/listeOrdonnances.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/medicaments/ajouterMedicaments.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/medicaments/listeMedicaments.dart';
import 'package:projet_semestre_7_espa_tco/models/modeleMedicaments.dart';
import 'package:projet_semestre_7_espa_tco/models/modeleOrdonnanceMedicale.dart';
import '../../services/servicesFirestoreOrdonnance.dart';

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
  TextEditingController controlleurDescriptionsMaladie = TextEditingController();
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
        title: Text("Modifier des notes"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirmation de la suppresion"),
                    content: Text("Êtes-vous sûr de vouloir supprimer cette ordonnance ?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await ServicesFirestoreOrdonnances().supprimmerOrdonnance(widget.ordonnance.id);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ListeOrdonnances(widget.patient)), (route) => false);
                        },
                        child: Text("Oui"),
                      ),
                      TextButton(
                        child: Text("Non"),
                        onPressed: () {Navigator.pop(context);},
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete, color: Colors.red,)
          ),
        ],
      ),



      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Titre",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: controlleurMaladie,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40.0,),
              Text(
                "Descriptions",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: controlleurDescriptionsMaladie,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 50.0,),
              Center(
                child: ElevatedButton(
                  child: Text("Voir médicaments"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ListeMedicaments(widget.patient, widget.ordonnance)));
                  },
                ),
              ),
              SizedBox(height: 50.0,),
              chargement ? Center(child: CircularProgressIndicator(),) : Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: Text(
                    "Mettre à jour les notes",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent.shade200),
                  onPressed: () async {
                    if (controlleurMaladie.text == "" || controlleurDescriptionsMaladie.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis"),backgroundColor: Colors.red,));
                    } else {
                      setState(() {
                        chargement = true;
                      });
                      await ServicesFirestoreOrdonnances().mettreAJourOrdonnance(widget.ordonnance.id, controlleurMaladie.text, controlleurDescriptionsMaladie.text);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ListeOrdonnances(widget.patient)), (route) => false);
                      setState(() {
                        chargement = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










