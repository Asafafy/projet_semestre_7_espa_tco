import 'package:Ordonnances/ecrans/authentificationsDocteurs/connexion_docteur.dart';
import 'package:Ordonnances/ecrans/ordonnances/detailOrdonnancePourPatient.dart';
import 'package:Ordonnances/models/modeleOrdonnanceMedicale.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../couleurs/couleurs.dart';
import '../../services/authentificationPatients.dart';
import '../authentificationsUtilisateurs/se_connecter.dart';
import "package:intl/intl.dart";


class ListeOrdonnances extends StatelessWidget {
  User utilisateur;
  ListeOrdonnances(this.utilisateur);

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des ordonnances"),
        centerTitle: true,
        backgroundColor: CouleursApplications.appBarVert,
        foregroundColor: CouleursApplications.textesAppBar,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await ServicesAuthentifications().seDeconnecter();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SeConnecter()), (route) => false);
            },
            icon: const Icon(Icons.logout, color: CouleursApplications.textesAppBar,),
            label: const Text("Déconnecter", style: TextStyle(color: CouleursApplications.textesAppBar),),
            style: TextButton.styleFrom(foregroundColor: Colors.black54),
          ),
        ],
      ),



      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ordonnancesMedicales').where('idUtilisateur', isEqualTo: utilisateur.uid).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    ModeleOrdonnanceMedicale ordonnance = ModeleOrdonnanceMedicale.fromJson(snapshot.data.docs[index]);
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      elevation: 5,
                      color: Colors.white54,
                       margin: const EdgeInsets.all(10.0),
                       child: ListTile(
                         leading: IconButton(
                           icon: const CircleAvatar(
                             backgroundColor: CouleursApplications.appBarVert,
                             foregroundColor: CouleursApplications.textesAppBar,
                             child: Icon(Icons.edit)),
                           onPressed: () async {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConnexionDocteur(utilisateur, ordonnance.date, true)));
                           },
                         ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        title: Text(ordonnance.maladie, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CouleursApplications.appBarVert),),
                        subtitle: Text(ordonnance.descriptionsMaladie, overflow: TextOverflow.ellipsis, maxLines: 2,),
                        trailing: Text(DateFormat('dd-MM-yy').format(ordonnance.date.toDate()), style: const TextStyle(fontStyle: FontStyle.italic),),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailOrdonnancePourPatient(utilisateur, ordonnance)));
                        },
                      ),
                    );
                  }
              );
            } else {
              return const Center(
                child: Text("Vous n'avez pas encore des ordonnances médicales"),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),



      floatingActionButton: FloatingActionButton(
        backgroundColor: CouleursApplications.appBarVert,
        foregroundColor: CouleursApplications.textesAppBar,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConnexionDocteur(utilisateur, null, false)));
        },
      ),
    );
  }
}
