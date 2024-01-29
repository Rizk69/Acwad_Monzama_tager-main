class ProductModel {
  String? message;
  List<Product>? product;

  ProductModel({this.message, this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

}

class Product {
  int? id;
  String? name;
  int? price;
  int? count = 0;

  Product({this.id, this.name, this.price, this.count});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

}
