import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class addProduit extends StatelessWidget {
  final marque_controller;
  final designation_controller;
  final categorie_controller;
  final photo_controller;
  final prix_controller;
  final quantite_controller;

  VoidCallback onAdd;
  VoidCallback onCancel;

  addProduit(
      {super.key,
      required this.marque_controller,
      required this.designation_controller,
      required this.categorie_controller,
      required this.photo_controller,
      required this.prix_controller,
      required this.quantite_controller,
      required this.onAdd,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 146, 150, 129),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 250, 248, 248),
          ),
        ),
        title: const Text(
          'Ajouter Un produit',
          style: TextStyle(
            color: Color.fromARGB(255, 235, 237, 237),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(padding: EdgeInsets.all(18.0)),
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: const Text(
            "Entrer les informations du produit : ",
            style: TextStyle(
              color: Color.fromARGB(255, 146, 150, 129),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              decoration: InputDecoration(
                  labelText: "Marque",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: marque_controller),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              decoration: InputDecoration(
                  labelText: "Designation",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: designation_controller),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              decoration: InputDecoration(
                  labelText: "Categorie",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: categorie_controller),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              decoration: InputDecoration(
                  labelText: "Photo",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: photo_controller),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Prix",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: prix_controller),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Quantite",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: quantite_controller),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: onAdd,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Ajouter Produit",
                    style: TextStyle(
                      color: Color.fromARGB(255, 235, 237, 237),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 146, 150, 129),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: onCancel,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Cancel",
                      style: TextStyle(
                        color: Color.fromARGB(255, 235, 237, 237),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 146, 150, 129),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
