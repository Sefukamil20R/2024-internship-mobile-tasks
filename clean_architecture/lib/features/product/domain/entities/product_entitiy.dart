import 'package:equatable/equatable.dart';
class ProductEntitiy extends Equatable{ 
 ProductEntitiy({
    required this.id,
    required this.name,
    required this.description,
    required this.imageurl,
    required this.price,
  });
  final int id;
  final String name;
  final String description;
  final String imageurl;
  final int price;
  
  @override
  
  List<Object?> get props => [id, name, description, imageurl, price];

  
}  


// *******why we extend Equatable Package
//  Dart checks object equality using reference equality.
// Two instances of a class are considered equal only i
//f they refer to the same memory location. When you extend Equatable,
// you can define equality based on the values of the object's properties, 
//which is useful for models where logical equivalence is determined by property values.
// Equatable is a package that makes it easy to compare objects in Dart.
// **** using props in Equatable
// The props getter is an abstract getter that returns a List of properties 
//that will be used to determine if two instances of the class are equal.
// This means two instances of ProductEntity will be considered equal
// if all properties listed in props are equal.