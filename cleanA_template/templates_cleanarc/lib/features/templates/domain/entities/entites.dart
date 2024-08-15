import 'package:equatable/equatable.dart';

class YourEntityName extends Equatable {
  YourEntityName({
    required this.id,
    required this.property1,
    required this.property2,
    // Add more properties as needed
  });

  final String id;
  final String property1;
  final String property2;
  // Add more fields as needed

  @override
  List<Object?> get props => [id, property1, property2]; 
  // Include all fields that should be considered for equality
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
// he props method defines which fields are used for equality comparison. 