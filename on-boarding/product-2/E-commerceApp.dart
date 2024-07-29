import 'dart:io';

void main() {
  ProductManager productManager = ProductManager();
  print("Welcome to Our E-commerce Application");

  while (true) {
    print("\nChoose an option:");
    print("1. Add products");
    print("2. Edit product");
    print("3. View products");
    print("4. View single product");
    print("5. Remove products");
    print("6. Exit from the program");

    var choice = stdin.readLineSync();
    switch (choice) {
      case "1":
        productManager.addProduct();
        break;
      case "2":
        productManager.editProduct();
        break;
      case "3":
        productManager.viewProducts();
        break;
      case "4":
        productManager.viewSingleProduct();
        break;
      case "5":
        productManager.removeProduct();
        break;
      case "6":
        print("Exiting the program...");
        return;
      default:
        print("Invalid choice. Please try again.");
    }
  }
}

class Product {
  String? _name;
  String? _description;
  double? _price;

  void setName(String? name) {
    _name = name;
  }

  String? getName() {
    return _name;
  }

  void setDescription(String? description) {
    _description = description;
  }

  String? getDescription() {
    return _description;
  }

  void setPrice(double? price) {
    _price = price;
  }

  double? getPrice() {
    return _price;
  }

  
}

class ProductManager {
  List<Product> products = [];

  // Add a new product
  void addProduct() {
    print("Enter product name:");
    String? newName = stdin.readLineSync();

    print("Enter product description:");
    String? newDescription = stdin.readLineSync();

    print("Enter product price:");
    String? newPrice = stdin.readLineSync();

    double parsedPrice;
    try {
      parsedPrice = double.parse(newPrice ?? '0');
    } catch (e) {
      print("Invalid price input. Setting price to 0.");
      parsedPrice = 0.0;
    }

    if (newName != null && newDescription != null) {
      Product product = Product();
      product.setName(newName.trim());
      product.setDescription(newDescription.trim());
      product.setPrice(parsedPrice);
      products.add(product);
      print("Product added successfully");
    } else {
      print("Invalid product name or description. Product name and description cannot be null.");
    }
  }

  // View all products
  void viewProducts() {
  if (products.isEmpty) {
    print("No products available.");
    return;
  }
  
  for (var product in products) {
    print('Product Name: ${product.getName()}, Description: ${product.getDescription()}, Price: ${product.getPrice()}');
  }
}


  // View a single product
  void viewSingleProduct() {
    print("Enter the product name that you want to view:");
    String? productName = stdin.readLineSync();
    if (productName != null) {
      for (var product in products) {
        if (productName.trim().toLowerCase() == product.getName()?.toLowerCase()) {
          print('Product Name: ${product._name}, Description: ${product._description}, Price: ${product._price}');
          return;
        }
      }
    }
    print("Product not found.");
  }

  // Edit a product (update name, description, price)
  void editProduct() {
    print("Enter the product name that you want to edit:");
    String? nameToEdit = stdin.readLineSync();
    if (nameToEdit != null) {
      for (var product in products) {
        if (nameToEdit.trim().toLowerCase() == product.getName()?.toLowerCase()) {
          print("Choose what you want to edit:");
          print("1. Name");
          print("2. Description");
          print("3. Price");
          var editChoice = stdin.readLineSync();
          switch (editChoice) {
            case "1":
              print("Enter new name:");
              String? newName = stdin.readLineSync();
              product.setName(newName);
              break;
            case "2":
              print("Enter new description:");
              String? newDescription = stdin.readLineSync();
              product.setDescription(newDescription);
              break;
            case "3":
              print("Enter new price:");
              String? newPrice = stdin.readLineSync();
              double parsedPrice;
              try {
                parsedPrice = double.parse(newPrice ?? '0');
              } catch (e) {
                print("Invalid price input. Setting price to 0.");
                parsedPrice = 0.0;
              }
              product.setPrice(parsedPrice);
              break;
            default:
              print("Invalid choice. Please try again.");
          }
          print("Product updated successfully");
          return;
        }
      }
    }
    print("Product not found.");
  }

  // Delete a product
  void removeProduct() {
    print("Enter the product name that you want to remove:");
    String? nameToRemove = stdin.readLineSync();
    if (nameToRemove != null) {
      bool found = false;
      products.removeWhere((product) {
        if (product.getName()?.toLowerCase() == nameToRemove.trim().toLowerCase()) {
          found = true;
          return true;
        }
        return false;
      });
      if (found) {
        print("Product removed successfully.");
      } else {
        print("Product not found.");
      }
    }
  }
}
