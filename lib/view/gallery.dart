import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:manic_flutter/helper/constants.dart';

class ImageGallery extends StatelessWidget {
  final List gallery;
  ImageGallery({required this.gallery});

  @override
  Widget build(BuildContext context) {
    List<Widget> galleryElements = gallery.map((image) {
      return Container(
        child: Image.network(
            'https://' + apiAddress + image['formats']['medium']['url'],
            fit: BoxFit.cover),
      );
    }).toList();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        enableInfiniteScroll: false,
        aspectRatio: 16 / 9,
        initialPage: 0,
        enlargeCenterPage: true,
      ),
      items: galleryElements,
    );
  }
}
