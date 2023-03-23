import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesFirestore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //  Création des nouveaux notes
  Future insererNote(String titre, String descriptions, String idUtilisateur) async {
    try {
      await firestore.collection('notes').add({
        "titre" : titre,
        "description" : descriptions,
        "date" : DateTime.now(),
        "idUtilisateur" : idUtilisateur,
      });
    } catch (e) {
      print(e);
    }
  }



  //  Mise à jour d'une note
  Future mettreAJourNote (String idDoc, String titre, String description) async {
    try {
      await firestore.collection('notes').doc(idDoc).update({
        'titre': titre,
        'description': description,
      });
    } catch(e) {
      print(e);
    }
  }



  //  Supprimer une note
  Future suppriomerNote (String idDoc) async {
    try {
      await firestore.collection('notes').doc(idDoc).delete();
    } catch(e) {
      print(e);
    }
  }



}