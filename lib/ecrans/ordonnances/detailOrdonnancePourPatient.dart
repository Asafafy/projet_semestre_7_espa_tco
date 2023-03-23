import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../couleurs/couleurs.dart';
import '../../models/modeleMedicaments.dart';
import '../../models/modeleOrdonnanceMedicale.dart';


class DetailOrdonnancePourPatient extends StatefulWidget {
  User patient;
  ModeleOrdonnanceMedicale ordonnance;

  DetailOrdonnancePourPatient(this.patient, this.ordonnance);

  @override
  State<DetailOrdonnancePourPatient> createState() =>
      _DetailOrdonnancePourPatientState();
}

class _DetailOrdonnancePourPatientState
    extends State<DetailOrdonnancePourPatient> {
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
        title: Text("Détail Ordonnance"),
        centerTitle: true,
        backgroundColor: CouleursApplications.appBarVert,
        foregroundColor: CouleursApplications.textesAppBar,
      ),

      body: Container(
        color: CouleursApplications.fondApplication,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                elevation: 5,
                child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
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
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        enabled: false,
                        minLines: 1,
                        maxLines: 5,
                        controller: controlleurMaladie,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
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
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        enabled: false,
                        controller: controlleurDescriptionsMaladie,
                        minLines: 1,
                        maxLines: 10,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "LISTE DES MEDICAMENTS",
                style: TextStyle(
                  color: CouleursApplications.appBarVert,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 15,),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('ordonnancesMedicales')
                        .doc(widget.ordonnance.id)
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
                                    onTap: () {},
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
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}