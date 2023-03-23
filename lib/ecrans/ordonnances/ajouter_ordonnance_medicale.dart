import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/ordonnances/listeOrdonnances.dart';
import 'package:projet_semestre_7_espa_tco/models/docteur.dart';
import '../../services/servicesFirestoreOrdonnance.dart';



class AjouterOrdonnance extends StatefulWidget {
  User patient;
  ModeleDocteur docteur;
  AjouterOrdonnance(this.patient, this.docteur);



  @override
  State<AjouterOrdonnance> createState() => _AjouterOrdonnanceState();
}



class _AjouterOrdonnanceState extends State<AjouterOrdonnance> {
  TextEditingController controlleurMaladie = TextEditingController();
  TextEditingController controlleurDescriptionsMaladie = TextEditingController();

  bool chargement = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter ordonnance médicale"),
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
              SizedBox(height: 20.0,),
              Text(
                "Maladie",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(height: 5.0,),
              TextField(
                controller: controlleurMaladie,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                "Descriptions de la Maladie",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22.0,
                ),
              ),
              TextField(
                controller: controlleurDescriptionsMaladie,
                minLines: 3,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 50.0,),
              chargement ? Center(child: CircularProgressIndicator()): Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: Text(
                    "Créer l'ordonnance",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent.shade200),
                  onPressed: () async {
                    if (controlleurMaladie.text == "" || controlleurDescriptionsMaladie == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis"), backgroundColor: Colors.red,));
                    } else {
                      setState(() {
                        chargement = true;
                      });
                      print(widget.docteur.id);
                      await ServicesFirestoreOrdonnances().insererOrdonnance(controlleurMaladie.text, controlleurDescriptionsMaladie.text, widget.patient.uid, widget.docteur.id);
                      setState(() {
                        chargement = false;
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ListeOrdonnances(widget.patient)), (route) => false); //Revenir sur l'écran "Liste Ordonnances"
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
