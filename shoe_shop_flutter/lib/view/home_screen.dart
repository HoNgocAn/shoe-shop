import 'package:flutter/material.dart';
import 'package:shoe_shop_flutter/components/text_home.dart';

import '../components/carousel.dart';
import '../components/category_list.dart';
import '../components/product_list.dart';
import '../components/search_bar_and_filter.dart';
import '../data/repository/category_repository.dart';
import '../data/repository/product_repository.dart';
import '../data/source/category_source.dart';
import '../data/source/product_source.dart';
import '../data/viewModel/category_view_model.dart';
import '../data/viewModel/product_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageUrls = [
    'https://img.freepik.com/free-psd/new-collection-fashion-sale-web-banner-template_120329-1507.jpg',
    'https://w7.pngwing.com/pngs/861/818/png-transparent-shoe-shop-facebook-banner.png',
    'https://i.pinimg.com/736x/09/82/69/098269da6311c75108a953ba8e4758d0.jpg',
  ];

  int selectedIndex = 0;
  int currentPage = 1;

  late CategoryViewModel _categoryViewModel;
  late ProductViewModel _productViewModel; // Khai báo ProductViewModel

  @override
  void initState() {
    super.initState();
    // Khởi tạo CategoryViewModel
    _categoryViewModel =
        CategoryViewModel(repository: CategoryRepositoryImpl(CategorySource()));
    _categoryViewModel.loadCategories();

    // Khởi tạo ProductViewModel
    _productViewModel =
        ProductViewModel(repository: ProductRepositoryImpl(ProductSource()));
    _productViewModel.loadProductData(page: currentPage);
  }

  @override
  void dispose() {
    // Giải phóng tài nguyên
    _categoryViewModel.dispose();
    _productViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // <--- Bọc ở đây
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarAndFilter(),
              const SizedBox(height: 20),
              Carousel(imageUrls: imageUrls),
              const SizedBox(height: 15),
              TextHome(text: "Category"),
              const SizedBox(height: 10),
              CategoryList(
                size: size,
                selectedIndex: selectedIndex,
                onSelect: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                categoryStream: _categoryViewModel.categoryStream.stream,
              ),
              TextHome(text: "Product"),
              const SizedBox(height: 10),
              ProductList(
                productStream: _productViewModel.productStream.stream,
                totalPagesStream: _productViewModel.totalPagesStream.stream,
                currentPage: currentPage,
                onPageChanged: (newPage) {
                  setState(() {
                    currentPage = newPage;
                  });
                  _productViewModel.loadProductData(page: newPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
