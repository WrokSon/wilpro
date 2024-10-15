import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImage {
  static Widget network(String url) {
    return CachedNetworkImage(
      imageUrl: url, // Image de la météo
      placeholder: (context, url) => const Center(
        child:
            CircularProgressIndicator(), // Affichage d'un indicateur de chargement en attendant le chargement de l'image
      ),
      errorWidget: (context, url, error) => const Icon(Icons
          .error), // Affichage d'une icône d'erreur en cas d'échec de chargement de l'image
      width: 70,
      height: 70,
      fit: BoxFit.cover,
    );
  }
}
