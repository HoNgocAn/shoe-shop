import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/model/category_model.dart';


class CategoryList extends StatelessWidget {
  final Size size;
  final int selectedIndex;
  final Function(int) onSelect;
  final Stream<List<Category>> categoryStream;

  const CategoryList({
    super.key,
    required this.size,
    required this.selectedIndex,
    required this.onSelect,
    required this.categoryStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
      stream: categoryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final categories = snapshot.data!;
          return Stack(
            children: [
              const Positioned(
                left: 0,
                right: 0,
                top: 40,
                child: Divider(color: Colors.black12),
              ),
              SizedBox(
                height: size.height * 0.15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () => onSelect(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: CachedNetworkImage(
                                imageUrl: category.image,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                errorWidget: (context, url, error) => Icon(Icons.broken_image, color: Colors.redAccent),
                                fadeInDuration: Duration(milliseconds: 300),
                                fit: BoxFit.cover, // nếu cần ảnh vừa khung
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 13,
                                color: isSelected ? Colors.black : Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 3,
                              width: 50,
                              color: isSelected ? Colors.black : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const Center(child: Text("No categories available."));
      },
    );
  }
}