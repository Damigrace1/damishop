class ProductModel {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final String category;
  final String subCategory;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.subCategory,
  });

  /* Factory method to create a ProductModel from JSON can be added here but since
   there is no remote backend integration, it has been limited here.*/
}
