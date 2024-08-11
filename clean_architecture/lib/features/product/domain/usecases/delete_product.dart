import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';

class DeleteProductusecase 
{
  final ProductRepositories productRepository;
  DeleteProductusecase(this.productRepository);
  
  Future<Either<Failure,ProductEntitiy>>deleteproduct(String productId)
  {
    return productRepository.deleteproduct(productId);
  }

}