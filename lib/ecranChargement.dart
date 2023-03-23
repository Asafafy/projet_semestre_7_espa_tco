import 'package:flutter/material.dart';

class EcranChargement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/ordonnance.png'),
                  width: 300,
                ),
                SizedBox(height: 50,),
                Text("Ordonnances medicales", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),),
              ],
            ),
          ),
        )
      );
  }
}
