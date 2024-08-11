import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/models/products_models.dart';
// import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:dartz/dartz.dart';

  abstract class ProductRepositories {
    Future<Either<Failure, List<ProductEntitiy>>> getAllProduct();
    Future<Either<Failure, ProductEntitiy>> getProductById(String productId);
    Future<Either<Failure,ProductEntitiy>> addproduct(ProductEntitiy product);
    Future<Either<Failure,ProductEntitiy>>updateproduct(String productId,ProductModel product );
    Future<Either<Failure,ProductEntitiy>>deleteproduct(String productId);
  }

