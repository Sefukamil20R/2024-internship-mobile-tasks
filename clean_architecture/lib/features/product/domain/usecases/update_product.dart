import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';
class UpdateProductusecase
{
  final ProductRepositories productRepositories;
  UpdateProductusecase(this.productRepositories);
  Future<Either<Failure,ProductEntitiy>>updateproduct(int productId)
  {
    return productRepositories.updateproduct(productId);
  }
}