import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';

class GetAllproductusecase 
{
  final ProductRepositories productRepository;
  GetAllproductusecase(this. productRepository);
  Future<Either<Failure, List<ProductEntitiy>>> getAllproduct()
  {
    return productRepository.getAllProduct();
  }
}