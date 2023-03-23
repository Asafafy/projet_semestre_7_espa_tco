import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesFirestoreMedicaments {

  //  Création des nouveaux notes
  Future insererMedicament(String idDocumentOrdonnances, String matin, String midi, String soir, String minuit, String nomMedicament, String nbrJour) async {
    try {
      CollectionReference SouscollectionMedicaments = FirebaseFirestore.instance
          .collection('ordonnancesMedicales')
          .doc(idDocumentOrdonnances)
          .collection('medicaments');
      await SouscollectionMedicaments.add({
        "matin": matin,
        "midi": midi,
        "soir": soir,
        "minuit": minuit,
        "nomMedicament": nomMedicament,
        "nbrJour": nbrJour,
      });
    } catch (e) {
    }
  }


  Future mettreAJour(String idMedicament, String idDocumentOrdonnances, String matin, String midi, String soir, String minuit, String nomMedicament, String nbrJour) async {
    try {
      DocumentReference SouscollectionMedicaments = FirebaseFirestore.instance
          .collection('ordonnancesMedicales')
          .doc(idDocumentOrdonnances)
          .collection('medicaments')
          .doc(idMedicament);
      await SouscollectionMedicaments.update({
        "matin": matin,
        "midi": midi,
        "soir": soir,
        "minuit": minuit,
        "nomMedicament": nomMedicament,
        "nbrJour": nbrJour,
      });
    } catch (e) {
    }
  }


}