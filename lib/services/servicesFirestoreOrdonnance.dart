import 'package:cloud_firestore/cloud_firestore.dart';


class ServicesFirestoreOrdonnances {
  FirebaseFirestore firestore = FirebaseFirestore.instance;



  Future insererOrdonnance(String maladie, String descriptionsMaladie, String idUtilisateur, String idDocteur) async {
    try {
      await firestore.collection('ordonnancesMedicales').add({
        "maladie" : maladie,
        "descriptionsMaladie" : descriptionsMaladie,
        "idUtilisateur" : idUtilisateur,
        "idDocteur" : idDocteur,
        "date" : DateTime.now(),
      });
    } catch (e) {
    }
  }



  //  Mise à jour d'une note
  Future mettreAJourOrdonnance(String? idDocOrdonnnace, String maladie, String descriptionsMaladie) async {
    try {
      await firestore.collection('ordonnancesMedicales').doc(idDocOrdonnnace).update({
        "maladie" : maladie,
        "descriptionsMaladie" : descriptionsMaladie,
      });
    } catch(e) {
    }
  }



  //  Supprimer une note
  Future supprimmerOrdonnance(String idDoc) async {
    try {
      await firestore.collection('ordonnancesMedicales').doc(idDoc).delete();
    } catch(e) {
    }
  }
}