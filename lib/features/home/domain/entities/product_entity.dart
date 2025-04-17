class ProductEntity {
  final int id;
  final String title;
  final num price;
  final double rating;
  final String thumbnail;
  final String category;
  final List<String> tags;

  ProductEntity( {
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
   required this.category, 
   required this.tags,
  });
}
