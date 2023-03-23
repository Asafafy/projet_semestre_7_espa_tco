import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_semestre_7_espa_tco/services/servicesFirestore.dart';

class AjouterNote extends StatefulWidget {
  User utilisateur;
  AjouterNote(this.utilisateur);

  @override
  State<AjouterNote> createState() => _AjouterNoteState();
}

class _AjouterNoteState extends State<AjouterNote> {
  TextEditingController controlleurTitre = TextEditingController();
  TextEditingController controlleurDescription = TextEditingController();
  bool chargement = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter des notes"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
      ),



      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Titre",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: controlleurTitre,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40.0,),
              Text(
                "Descriptions",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: controlleurDescription,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 50.0,),
              chargement ? Center(child: CircularProgressIndicator(),): Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: Text(
                    "Ajouter les notes",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent.shade200),
                  onPressed: () async {
                    if (controlleurTitre.text == "" || controlleurDescription == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis"), backgroundColor: Colors.red,));
                    } else {
                      setState(() {
                        chargement = true;
                      });
                      await ServicesFirestore().insererNote(controlleurTitre.text, controlleurDescription.text, widget.utilisateur.uid);
                      setState(() {
                        chargement = false;
                        Navigator.pop(context); //Revenir sur l'écran "Accueil"
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
