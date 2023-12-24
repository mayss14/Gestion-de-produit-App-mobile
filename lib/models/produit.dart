import 'package:cloud_firestore/cloud_firestore.dart';

class Produit {
  String id;
  String Marque;
  String categorie;
  String designation;
  String photo;
  double prix;

  int quantite;

  Produit(
      {required this.id,
      required this.Marque,
      required this.categorie,
      required this.designation,
      required this.photo,
      required this.prix,
      required this.quantite});

  //constructeur firestore ==> cree l objet produit a partir d un document firestore
  factory Produit.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Produit(
        id: doc.id,
        Marque: data['Marque'] ?? '',
        categorie: data['categorie'] ?? '',
        designation: data['designation'] ?? '',
        photo: data['photo'] ?? '',
        prix: data['prix'] ?? 0.0,
        quantite: data['quantite'] ?? 0);
  }
}
