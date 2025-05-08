import 'package:flutter/material.dart';


class SearchBarAndFilter extends StatelessWidget {
  const SearchBarAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 27,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.black38,
                  )
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 32,
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Find product",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              // Hiển thị dialog khi nhấn vào icon lọc
              _showFilterDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.tune,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm hiển thị dialog lọc
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Products'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lọc theo tên sản phẩm
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  hintText: 'Enter product name',
                ),
              ),
              const SizedBox(height: 10),

              // Lọc theo giá
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Min Price',
                        hintText: 'Enter min price',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Max Price',
                        hintText: 'Enter max price',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng dialog khi nhấn "Cancel"
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng dialog khi nhấn "Apply"
                // Bạn có thể lấy các giá trị lọc ở đây và thực hiện hành động lọc
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}