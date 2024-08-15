

// About Factory Constructor
// A factory constructor in Dart is a special type of constructor that doesn’t always create
// a new instance of a class. Instead, it can return an existing instance, 
//create an instance of a different class, or perform other complex initialization logic.
// Unlike regular constructors, factory constructors are not obligated to create 
//a new instance of the class every time they are called.
// They can return an instance from a cache or another source.
// id: json['id']: Maps the id field from the JSON object to the id field in the ProductModel class.
// . It’s called fromJson to indicate that it creates a ProductModel instance from a JSON object
// The toJson method you've provided is a concise way to convert an instance of a class into a
// JSON-compatible map. This map can be easily encoded into a JSON string for storage or transmission
// Map<String, dynamic> toJson():
// This method is defined to return a Map<String, dynamic>. In Dart, Map<String, dynamic> 
//is a type of map where keys are strings and values can be of any type.
// toEntity method and the listToEntity method. These methods are commonly used in the context of 
//converting data models to domain entities in an application.
// The toEntity method is used to convert an instance of a model class 
//(like EcommerceModel) into a domain entity class (like EcommerceEntity). 
// The listToEntity method converts a list of model instances to a list of domain entities.


// About Factory Constructor
// A factory constructor in Dart is a special type of constructor that doesn’t always create
// a new instance of a class. Instead, it can return an existing instance, 
//create an instance of a different class, or perform other complex initialization logic.
// Unlike regular constructors, factory constructors are not obligated to create 
//a new instance of the class every time they are called.
// They can return an instance from a cache or another source.
// id: json['id']: Maps the id field from the JSON object to the id field in the ProductModel class.
// . It’s called fromJson to indicate that it creates a ProductModel instance from a JSON object
// The toJson method you've provided is a concise way to convert an instance of a class into a
// JSON-compatible map. This map can be easily encoded into a JSON string for storage or transmission
// Map<String, dynamic> toJson():
// This method is defined to return a Map<String, dynamic>. In Dart, Map<String, dynamic> 
//is a type of map where keys are strings and values can be of any type.
// toEntity method and the listToEntity method. These methods are commonly used in the context of 
//converting data models to domain entities in an application.
// The toEntity method is used to convert an instance of a model class 
//(like EcommerceModel) into a domain entity class (like EcommerceEntity). 
// The listToEntity method converts a list of model instances to a list of domain entities.
