import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  List<Widget> _buildPageButtons() {
    List<Widget> buttons = [];

    void addPage(int page) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: TextButton(
            onPressed: () => onPageChanged(page),
            style: TextButton.styleFrom(
              backgroundColor: currentPage == page ? Colors.blue : Colors.transparent,
              foregroundColor: currentPage == page ? Colors.white : Colors.black,
              minimumSize: const Size(36, 36),
            ),
            child: Text('$page'),
          ),
        ),
      );
    }

    void addEllipsis() {
      buttons.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('...', style: TextStyle(fontSize: 18)),
      ));
    }

    if (totalPages <= 6) {
      for (int i = 1; i <= totalPages; i++) {
        addPage(i);
      }
    } else {
      addPage(1);

      if (currentPage > 3) addEllipsis();

      int start = currentPage - 1;
      int end = currentPage + 1;

      if (start <= 1) start = 2;
      if (end >= totalPages) end = totalPages - 1;

      for (int i = start; i <= end; i++) {
        addPage(i);
      }

      if (currentPage < totalPages - 2) addEllipsis();

      addPage(totalPages);
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: currentPage > 1
                ? () => onPageChanged(currentPage - 1)
                : null,
          ),
          ..._buildPageButtons(),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: currentPage < totalPages
                ? () => onPageChanged(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }
}