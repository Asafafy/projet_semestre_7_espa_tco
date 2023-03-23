import 'package:cloud_firestore/cloud_firestore.dart';


class ModeleMedicament {
  String idOrdonnance;
  String nomMedicament;
  String matin;
  String midi;
  String soir;
  String minuit;
  String nbrJour;

  ModeleMedicament({
    required this.idOrdonnance,
    required this.nomMedicament,
    required this.matin,
    required this.midi,
    required this.soir,
    required this.minuit,
    required this.nbrJour,
  });

  factory ModeleMedicament.fromJson(DocumentSnapshot snapshot) {
    return ModeleMedicament(
      idOrdonnance: snapshot.id,
      nomMedicament : snapshot['nomMedicament'],
        matin : snapshot['matin'],
        midi: snapshot['midi'],
        soir : snapshot['soir'],
        minuit: snapshot['minuit'],
        nbrJour: snapshot['nbrJour']
    );
  }
}