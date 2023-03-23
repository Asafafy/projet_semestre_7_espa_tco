import 'package:Ordonnances/models/docteur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ecrans/ordonnances/ajouter_ordonnance_medicale.dart';
import '../ecrans/ordonnances/modifierOrdonnance.dart';
import '../models/modeleOrdonnanceMedicale.dart';



class AuthentificationDocteur {
  FirebaseFirestore firestore = FirebaseFirestore.instance;



  //  Fonction pour la connection
  Future<String?> seConnecterDocteur(String nomDocteur, String motDePasseDocteur, User patient, bool estEdition, Timestamp? dateOrdonnance, BuildContext context) async {
    try {
      CollectionReference collectionDocteur = firestore.collection('docteurs');
      QuerySnapshot documentsDocteurs = await collectionDocteur.where("nomDocteur", isEqualTo: nomDocteur).get();
      if (documentsDocteurs.docs.length < 1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Aucune correspondance n'a été trouvée"), backgroundColor: Colors.red,));
      } else {
        documentsDocteurs.docs.forEach((element) async {
          ModeleDocteur docteur = ModeleDocteur.fromJson(element);
          if (docteur.nomDocteur == nomDocteur && docteur.motDePasse == motDePasseDocteur) {
            if (estEdition) {
              CollectionReference collectionOrdonnnance = firestore.collection('ordonnancesMedicales');
              QuerySnapshot documentsOrdonnnances = await collectionOrdonnnance.where("date", isEqualTo: dateOrdonnance).get();
              documentsOrdonnnances.docs.forEach((element) async {
                ModeleOrdonnanceMedicale ordonnance = ModeleOrdonnanceMedicale.fromJson(element);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ModifierOrdonnance(ordonnance, patient, null)), (route) => false);
              });
            } else {
              ModeleDocteur docteurPush = ModeleDocteur(id: docteur.id, nomDocteur: docteur.nomDocteur, email: docteur.email, motDePasse: docteur.motDePasse);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AjouterOrdonnance(patient, docteurPush)), (route) => false);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mot de passe incorrect"), backgroundColor: Colors.red,));
          }
        });
      }
    } catch(e){
    }
  }
}