import 'package:flutter/material.dart';

class EcranChargement extends StatelessWidget {
  const EcranChargement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
