import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';

class AddProductUseCase {
  final ProductRepositories productRepositories;

  AddProductUseCase(this.productRepositories);

  Future<Either<Failure, ProductEntitiy>> addProduct(ProductEntitiy product) {
    return productRepositories.addproduct(product);
  }
}




// The Either type from the dartz package is used to 
//handle cases where a function can either return a value of type Right 
//or an error of type Left.