import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../models/modeleMedicaments.dart';
import '../../models/modeleOrdonnanceMedicale.dart';


class DetailOrdonnancePourPatient extends StatelessWidget {
  User patient;
  ModeleOrdonnanceMedicale ordonnance;
  DetailOrdonnancePourPatient(this.patient, this.ordonnance);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordonnance"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
                        .collection('ordonnancesMedicales')
                        .doc(ordonnance.id)
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
                        onTap: () {},
                      ),
                    );
                  }
              );
            } else {
              return Center(
                child: Text("Vous n'avez pas encore des medicaments"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
