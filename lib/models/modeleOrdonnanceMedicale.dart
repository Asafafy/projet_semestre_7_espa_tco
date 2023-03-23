import 'package:cloud_firestore/cloud_firestore.dart';


//  Classe pour les préscriptions médicales.
class ModeleOrdonnanceMedicale {
  String id;
  String maladie;
  String descriptionsMaladie;
  String idDocteur;
  String idUtilisateur;
  Timestamp date;


  ModeleOrdonnanceMedicale({
    required this.id,
    required this.maladie,
    required this.descriptionsMaladie,
    required this.idUtilisateur,
    required this.idDocteur,
    required this.date,
  });


  factory ModeleOrdonnanceMedicale.fromJson(DocumentSnapshot snapshot) {
    return ModeleOrdonnanceMedicale(
      id: snapshot.id,
      maladie: snapshot['maladie'],
      descriptionsMaladie: snapshot['descriptionsMaladie'],
      idUtilisateur: snapshot['idUtilisateur'],
      idDocteur: snapshot['idDocteur'],
      date: snapshot['date'],
    );
  }
}