import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';

class GetSpecproductsusecase
{
  final ProductRepositories productRepository;
  GetSpecproductsusecase(this.productRepository);
  
  // ignore: non_constant_identifier_names
  Future<Either<Failure,ProductEntitiy>>GetSpecproduct(String productId)
  {
    return productRepository.getProductById(productId);
  }

}