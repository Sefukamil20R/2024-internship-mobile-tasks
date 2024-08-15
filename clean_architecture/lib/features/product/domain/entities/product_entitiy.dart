import 'package:equatable/equatable.dart';
class ProductEntitiy extends Equatable{ 
 ProductEntitiy({
    required this.id,
    required this.name,
    required this.description,
    required this.imageurl,
    required this.price,
  });
  final String id;
  final String name;
  final String description;
  final String imageurl;
  final double price;
  
  @override
  
  List<Object?> get props => [id, name, description, imageurl, price];

  
}  


