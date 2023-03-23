import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/medicaments/ajouterMedicaments.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/medicaments/modifierMedicament.dart';
import 'package:projet_semestre_7_espa_tco/models/modeleMedicaments.dart';
import 'package:projet_semestre_7_espa_tco/models/modeleOrdonnanceMedicale.dart';

import '../../authentificationsDocteurs/connexion_docteur.dart';

class ListeMedicaments extends StatelessWidget {
  User patient;
  ModeleOrdonnanceMedicale ordonnanceMedicale;
  ListeMedicaments(this.patient, this.ordonnanceMedicale);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des médicaments"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
      ),



      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('ordonnancesMedicales')
          .doc(ordonnanceMedicale.id)
          .collection('medicaments').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    ModeleMedicament medicament = ModeleMedicament.fromJson(snapshot.data.docs[index]);
                    return Card(
                      color: Colors.teal.shade200,
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        title: Text(medicament.nomMedicament, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                        subtitle: Text(medicament.nbrJour, overflow: TextOverflow.ellipsis, maxLines: 2,),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ModifierMedicaments(ordonnanceMedicale, patient, medicament)), (route) => false,);
                        },
                      ),
                    );
                  }
              );
            } else {
              return Center(
                child: Text("Vous n'avez pas encore des médicaments"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),



      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AjouterMedicaments(patient, ordonnanceMedicale, null)));
        },
      ),
    );
  }
}
