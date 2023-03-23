import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ServicesAuthentifications{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  //  Fonction S'inscrire
  Future sInscrire(String nom, String email, String motDePasse, bool valCheckbox, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: motDePasse);
      return userCredential.user;
    } on FirebaseAuthException catch(e) {
      String messageDErreur = "";
      switch (e.code) {
        case 'invalid-email':
          messageDErreur = 'L\'adresse e-mail est mal formatée.';
          break;
        case 'email-already-in-use':
          messageDErreur = 'L\'adresse e-mail est déjà utilisée.';
          break;
        case 'weak-password' :
          messageDErreur = "Le mot de passe doit contenir au moins 6 caractères";
          break;
        default:
          messageDErreur = 'Une erreur s\'est produite lors de l\'authentification.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messageDErreur), backgroundColor: Colors.red,));
    } catch(e) {
      print(e);
    }
  }


  //  Fonction Se connecter
  Future<User?> seConnecter(String email, String motDePasse, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: motDePasse);
      return userCredential.user;
    } on FirebaseAuthException catch(e) {
      String messageDErreur;
      switch (e.code) {
        case 'invalid-email':
          messageDErreur = 'L\'adresse e-mail est mal formatée.';
          break;
        case 'user-not-found':
          messageDErreur = 'L\'utilisateur n\'a pas été trouvé.';
          break;
        case 'wrong-password':
          messageDErreur = 'Le mot de passe est incorrect.';
          break;
        default:
          messageDErreur =
          'Une erreur s\'est produite lors de l\'authentification.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messageDErreur), backgroundColor: Colors.red,));
    } catch(e) {
      print(e);
    }
  }


  //  Fonction Se Déconnecter
  Future seDeconnecter() async {
    await firebaseAuth.signOut();
  }

}