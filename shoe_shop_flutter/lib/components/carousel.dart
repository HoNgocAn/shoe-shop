import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class Carousel extends StatelessWidget {
  final List<String> imageUrls;

  const Carousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Điều chỉnh giá trị này để bo tròn góc
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 200, // Chiều cao của carousel
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
      ),
    );
  }
}