import 'package:app1/models/produit.dart';
import 'package:app1/ui.dart/produitDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Favoris extends StatelessWidget {
  const Favoris({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
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
          'Favoris',
          style: TextStyle(
            color: Color.fromARGB(255, 235, 237, 237),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("users")
            .doc(auth.currentUser!.uid)
            .collection("fav-items")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 146, 150, 129),
            ));
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucune donnée disponible'));
          }

          List<Produit> produits = snapshot.data!.docs.map((doc) {
            return Produit.fromFirestore(doc);
          }).toList();

          return ListView.builder(
            itemCount: produits.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 146, 150, 129),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                      title: Text(
                        produits[index].Marque + produits[index].designation,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(produits[index].prix.toString() + "DH"),
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 146, 150, 129),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 234, 243, 245),
                          ),
                        ),
                      ),
                      trailing: Visibility(
                        visible: auth.currentUser!.uid ==
                            "xCGOjKsrGIemleqkm0WdOBeAIY43",
                        child: IconButton(
                          color: Color.fromARGB(255, 146, 150, 129),
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            //Suppression d'un produit
                          },
                        ),
                      ),
                      onTap: () {
                        //Affichage d'un produit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProduitDetails(p: produits[index]),
                          ),
                        );
                      }),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
