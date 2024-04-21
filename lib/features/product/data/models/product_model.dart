class ProductModel {
  int? id;
  int? accountId;
  String? title;
  int? price;
  String? image;

  ProductModel({
    this.id,
    this.accountId,
    this.title,
    this.price,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int?,
        accountId: json['accountID'] as int?,
        title: json['title'] as String?,
        price: json['price'] as int?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'accountID': accountId,
        'title': title,
        'price': price,
        'image': image,
      };
}
