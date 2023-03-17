import 'package:flutter/material.dart';
import 'package:projet_semestre_7_espa_tco/ecrans/se_connecter.dart';
import 'package:projet_semestre_7_espa_tco/services/servicesAuthentifications.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: const Text("Accueil"),
        ),
        centerTitle: false,
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.black54,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await ServicesAuthentifications().seDeconnecter();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SeConnecter()), (route) => false);
            },
            icon: Icon(Icons.logout),
            label: Text("Se déconnecter"),
            style: TextButton.styleFrom(foregroundColor: Colors.black54),
          ),
        ],
      ),
    );
  }
}
