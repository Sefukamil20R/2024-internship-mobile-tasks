import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:dartz/dartz.dart';

  abstract class ProductRepositories {
    Future<Either<Failure, List<ProductEntitiy>>> getAllProducts();
    Future<Either<Failure, ProductEntitiy>> getProductById(int productId);
    Future<Either<Failure,ProductEntitiy>> addproduct(ProductEntitiy product);
    Future<Either<Failure,ProductEntitiy>>updateproduct(int productId);
    Future<Either<Failure,ProductEntitiy>>deleteproduct(int productId);
  }

