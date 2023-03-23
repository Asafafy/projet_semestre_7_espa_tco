import 'package:cloud_firestore/cloud_firestore.dart';


//  Classe pour les préscriptions médicales.
class ModeleDocteur {
  String id;
  String nomDocteur;
  String email;
  String motDePasse;


  ModeleDocteur ({
    required this.id,
    required this.nomDocteur,
    required this.email,
    required this.motDePasse
  });


  factory ModeleDocteur.fromJson(DocumentSnapshot snapshot) {
    return ModeleDocteur(
      id : snapshot.id,
      nomDocteur : snapshot['nomDocteur'],
      email : snapshot['email'],
      motDePasse : snapshot['motDePasse'],
    );
  }


}

