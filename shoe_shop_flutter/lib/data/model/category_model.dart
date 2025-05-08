class Category {
  int id; // Đổi từ String thành int
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  // Chuyển đổi từ Map thành Category
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int, // Đảm bảo 'id' là kiểu int
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Category &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Category{id: $id, name: $name, image: $image}';
  }
}