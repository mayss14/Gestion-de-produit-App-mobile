// ignore_for_file: prefer_const_constructors

import 'package:app1/models/produit.dart';
import 'package:app1/ui.dart/list_produits.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProduitDetails extends StatelessWidget {
  ProduitDetails({Key? key, required this.p}) : super(key: key);

  final Produit p;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 146, 150, 129),
        title: const Text(
          'Details Produit',
          style: TextStyle(
            color: Color.fromARGB(255, 244, 242, 242),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 250, 248, 248),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .50,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              image: DecorationImage(
                image: NetworkImage(p.photo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40, right: 44, left: 44),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.categorie,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          p.Marque,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          p.prix.toString() + "MAD",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Découvrez le " +
                          p.designation +
                          ", le smartphone qui allie élégance et performances exceptionnelles. Doté d'un design raffiné, ce bijou technologique offre une expérience utilisateur incomparable",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.w200),
                    ),
                    Visibility(
                      visible: auth.currentUser!.uid !=
                          "xCGOjKsrGIemleqkm0WdOBeAIY43",
                      child: Container(
                        margin: EdgeInsets.only(top: 30, left: 70),
                        child: SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () {
                              //Ajout d'un produit au favoris

                              collectionRef
                                  .doc(auth.currentUser!.uid)
                                  .collection("fav-items")
                                  .doc()
                                  .set({
                                "id": p.id,
                                "designation": p.designation,
                                "prix": p.prix,
                                "Marque": p.Marque,
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListProd(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Ajouter au Favoris",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 244, 242, 242),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Icon(Icons.favorite_sharp),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 146, 150, 129),
                              onPrimary: Colors.white,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
