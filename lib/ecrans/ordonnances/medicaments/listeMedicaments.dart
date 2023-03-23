import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/medicaments/ajouterMedicaments.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/medicaments/modifierMedicament.dart';
import 'package:projet_semestre_7_espa_tco/models/modeleMedicaments.dart';
import 'package:projet_semestre_7_espa_tco/models/modeleOrdonnanceMedicale.dart';
import '../../../couleurs/couleurs.dart';

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
        backgroundColor: CouleursApplications.appBarVert,
        foregroundColor: CouleursApplications.textesAppBar,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      elevation: 5,
                      color: Colors.green.shade100,
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: IconButton(
                          icon: CircleAvatar(
                              backgroundColor: CouleursApplications.appBarVert,
                              foregroundColor: CouleursApplications.textesAppBar,
                              child: Icon(Icons.list)),
                          onPressed: () async {},
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        title: Text(medicament.nomMedicament, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CouleursApplications.appBarVert),),
                        subtitle: Text(
                          "Matin : " + medicament.matin + "     Midi : " + medicament.midi + "     Soir : " + medicament.soir + "     Minuit : " + medicament.minuit,
                          overflow: TextOverflow.ellipsis, maxLines: 2,
                        ),
                        trailing: Text(medicament.nbrJour + "jrs"),
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
        backgroundColor: CouleursApplications.appBarVert,
        foregroundColor: CouleursApplications.textesAppBar,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AjouterMedicaments(patient, ordonnanceMedicale, null)));
        },
      ),
    );
  }
}
