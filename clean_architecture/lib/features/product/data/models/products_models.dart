import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';



class ProductModel extends ProductEntitiy {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageurl, // Match the JSON key
    required super.price, 
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageurl: json['imageUrl'], // Match the JSON key
      price: json['price'].toDouble(),
    );
  }
// factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'] as String? ?? '', // Default to empty string if null
//       name: json['name'] as String? ?? '',
//       price: (json['price']) ?? 0, // Convert to double and default to 0.0 if null
//       description: json['description'] as String? ?? '',
//       imageurl: json['imageurl'] as String? ?? '',
//     );
//   }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageurl': imageurl, // Match the JSON key
      'price': price,
    };
  }
  ProductEntitiy toEntity() => ProductEntitiy(
    id:id,
    name: name,
    description: description,
    imageurl: imageurl,
    price: price
  );
  static List<ProductEntitiy> listToEntity(List<ProductModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ProductModel &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           name == other.name &&
//           price == other.price &&
//           description == other.description &&
//           imageurl == other.imageurl;
  

//   @override
//   int get hashCode =>
//       id.hashCode ^ name.hashCode ^ price.hashCode ^ description.hashCode ^ imageurl.hashCode;
// }


// class ProductModel extends ProductEntitiy
// {
//   ProductModel({
//     required super.id,
//     required super.name,
//     required super.description,
//     required super.imageurl,
//     required super.price,
// });
//  factory ProductModel.fromJson(dynamic json) => ProductModel(
//     id: json['id'] ?? 0,
//     name: json['title'] ?? '',
//     description: json['description'] ?? '',
//     imageurl: json['image'] ?? '',
//     price: json['price'].toDouble() ?? 0.0,
//   );
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'description': description,
//     'imageurl': imageurl,
//     'price': price
//   };
//   ProductEntitiy toEntity() => ProductEntitiy(
//     id:id,
//     name: name,
//     description: description,
//     imageurl: imageurl,
//     price: price
//   );
//   static List<ProductEntitiy> listToEntity(List<ProductModel> models) {
//     return models.map((model) => model.toEntity()).toList();
//   }
// }




// class ProductModel extends ProductEntitiy {
//   ProductModel({
//     required int id,
//     required String name,
//     required String description,
//     required String imageurl,
//     required double price,
//   }) : super(
//     id: id,
//     name: name,
//     description: description,
//     imageurl: imageurl,
//     price: price,
//   );

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       description: json['description'] as String,
//       imageurl: json['imageurl'] as String,  
//       price: (json['price'] as num).toDouble(),  
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'imageUrl': imageurl,  // Correct key name
//       'price': price,
//     };
//   }
// }
}