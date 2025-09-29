class ProductListModal {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;
  int count;

  ProductListModal({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.count=1,
  });

  factory ProductListModal.fromJson(Map<String, dynamic> json) =>
      ProductListModal(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        price: json["price"]?.toDouble(),
        description: json["description"] ?? '',
        category: json["category"] ?? '',
        image: json["image"] ?? '',
        rating: Rating.fromJson(json["rating"]),
      );
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"] ?? 0,
      );
}
