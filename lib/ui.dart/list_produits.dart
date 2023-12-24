import 'package:app1/ui.dart/Favoris.dart';
import 'package:app1/ui.dart/UserProfile.dart';
import 'package:app1/ui.dart/addProduit.dart';
import 'package:app1/models/produit.dart';
import 'package:app1/ui.dart/produitDetails.dart';
import 'package:app1/ui.dart/produitItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ListProd extends StatefulWidget {
  const ListProd({super.key});

  @override
  State<ListProd> createState() => _ListProdState();
}

class _ListProdState extends State<ListProd> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController marque_controller = TextEditingController();
  TextEditingController designation_controller = TextEditingController();
  TextEditingController categorie_controller = TextEditingController();
  TextEditingController photo_controller = TextEditingController();
  TextEditingController prix_controller = TextEditingController();
  TextEditingController quantite_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*
    firestore.collection('prods').add({
      'Marque': 'Samsung',
      'categorie': 'Smartphone',
      'designation': 'Galaxy S21',
      'photo': 'https://www.samsung.com/fr/smartphones/galaxy-s21-5g/',
      'prix': 859,
      'quantite': 10
    });*/

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catalogue de  produits',
          style: TextStyle(
            color: Color.fromARGB(255, 244, 242, 242),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 146, 150, 129),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Color.fromARGB(255, 244, 242, 242),
            onPressed: () {
              auth.signOut();
            },
          ),
          Visibility(
            visible: auth.currentUser!.uid != "xCGOjKsrGIemleqkm0WdOBeAIY43",
            child: IconButton(
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Favoris()))
              },
              icon: Icon(
                Icons.favorite_sharp,
                color: Color.fromARGB(255, 244, 242, 242),
              ),
            ),
          ),
          Visibility(
            visible: auth.currentUser!.uid != "xCGOjKsrGIemleqkm0WdOBeAIY43",
            child: IconButton(
                color: Color.fromARGB(255, 244, 242, 242),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfile()))
                    },
                icon: Icon(Icons.person_2)),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('prods').snapshots(),
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
                            await firestore
                                .collection('prods')
                                .doc(produits[index].id)
                                .delete();

                            setState(() {
                              produits.removeAt(index);
                            });
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
      floatingActionButton: Visibility(
        visible: auth.currentUser!.uid == "xCGOjKsrGIemleqkm0WdOBeAIY43",
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 146, 150, 129),
          foregroundColor: Colors.white,
          onPressed: //Ajout d'un produit
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => addProduit(
                    marque_controller: marque_controller,
                    designation_controller: designation_controller,
                    categorie_controller: categorie_controller,
                    photo_controller: photo_controller,
                    prix_controller: prix_controller,
                    quantite_controller: quantite_controller,
                    onAdd: () async {
                      //Ajout d'un produit
                      await firestore.collection('prods').add({
                        'Marque': marque_controller.text,
                        'categorie': categorie_controller.text,
                        'designation': designation_controller.text,
                        'photo': photo_controller.text,
                        'prix': prix_controller,
                        'quantite': quantite_controller
                      });
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      Navigator.pop(context);
                    },
                  ),
                ));
          },
          tooltip: 'Ajouter un produit',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
