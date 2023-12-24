import 'package:app1/models/produit.dart';
import 'package:flutter/material.dart';

class ProduitItem extends StatelessWidget {
  const ProduitItem({super.key, required this.produit});

  final Produit produit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(produit.designation),
      subtitle: Text(produit.Marque),
    );
  }
}
