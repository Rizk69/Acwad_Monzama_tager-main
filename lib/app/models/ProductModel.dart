class ProductModel {
  String? message;
  List<ProductData>? product;

  ProductModel({this.message, this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['product'] != null) {
      product = <ProductData>[];
      json['product'].forEach((v) {
        product!.add(new ProductData.fromJson(v));
      });
    }
  }
}

class ProductData {
  int? id;
  String? name;
  num? price;
  int? count = 1;

  ProductData({this.id, this.name, this.price, this.count});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  ProductData copyWith({
    int? id,
    String? name,
    int? price,
    int? count,
  }) {
    int? convertedPrice;
    if (price != null) {
      convertedPrice = price.toInt();
    }

    return ProductData(
      id: id ?? this.id,
      name: name ?? this.name,
      price: convertedPrice ?? this.price,
      count: count ?? this.count,
    );
  }
}
