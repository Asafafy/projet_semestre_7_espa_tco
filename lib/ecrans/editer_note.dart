import 'package:flutter/material.dart';
//import 'package:projet_semestre_7_espa_tco/models/note.dart';
import 'package:projet_semestre_7_espa_tco/services/servicesFirestore.dart';

class ModifierNote extends StatefulWidget {
  //ModeleNote note;
  //ModifierNote(this.note);

  @override
  State<ModifierNote> createState() => _ModifierNoteState();
}

class _ModifierNoteState extends State<ModifierNote> {
  TextEditingController controlleurTitre = TextEditingController();
  TextEditingController controlleurDescription = TextEditingController();
  bool chargement = false;

  @override
  void initState() {
    // controlleurTitre.text = widget.note.titre;
    // controlleurDescription.text = widget.note.descriptions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier des notes"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirmation de la suppresion"),
                    content: Text("Êtes-vous sûr de vouloir supprimer cette note ?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          //await ServicesFirestore().suppriomerNote(widget.note.id);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("Oui"),
                      ),
                      TextButton(
                        onPressed: () {Navigator.pop(context);},
                        child: Text("Non"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete, color: Colors.red,)
          ),
        ],
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
              chargement ? Center(child: CircularProgressIndicator(),) : Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: Text(
                    "Mettre à jour les notes",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent.shade200),
                  onPressed: () async {
                    if (controlleurTitre.text == "" || controlleurDescription.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tous les champs sont requis"),backgroundColor: Colors.red,));
                    } else {
                      setState(() {
                        chargement = true;
                      });
                      //await ServicesFirestore().mettreAJourNote(widget.note.id, controlleurTitre.text, controlleurDescription.text);
                      setState(() {
                        chargement = false;
                        Navigator.pop(context);
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
