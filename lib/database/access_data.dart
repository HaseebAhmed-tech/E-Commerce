import 'package:cloud_firestore/cloud_firestore.dart';

import 'data.dart';

class AccessData {
  AccessData();
  static fetchCarouselImages(List<String> carouselImages) async {
    final QuerySnapshot carouselImagesQuerySnapshot =
        await Data.accessCarouselImages();

    for (int i = 0; i < carouselImagesQuerySnapshot.docs.length; i++) {
      carouselImages.add(carouselImagesQuerySnapshot.docs[i]["path"]);
    }
  }

  static fetchProductsInfo(List products) async {
    final QuerySnapshot productsQuerySnapshot = await Data.accessProductsInfo();
    for (int i = 0; i < productsQuerySnapshot.docs.length; i++) {
      products.add(
        {
          "product-description": productsQuerySnapshot.docs[i]
              ["product-description"],
          "product-price": productsQuerySnapshot.docs[i]["product-price"],
          "product-images": productsQuerySnapshot.docs[i]["product-images"],
          "product-name": productsQuerySnapshot.docs[i]["product-name"],
          "product-quality": productsQuerySnapshot.docs[i]["product-quality"],
          "product-rating": productsQuerySnapshot.docs[i]["product-rating"],
        },
      );
    }
  }
}
