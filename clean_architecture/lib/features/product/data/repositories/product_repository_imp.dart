import 'dart:io'; 
import 'package:clean_architecture/core/Network/Network_info.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_architecture/features/product/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/features/product/data/models/products_models.dart';


class ProductRepositoryImpl implements ProductRepositories {
  final RemoteDataSource remoteDataSource;
  final Network_info network_info;
  final LocalDataSource localDataSource;

  ProductRepositoryImpl({required this.remoteDataSource , required this.network_info , required this.localDataSource});

  @override
  Future<Either<Failure, ProductEntitiy>> addproduct(ProductEntitiy product) async {
    final isConnected = await network_info.isConnected;
       if (isConnected == true){ try {
      final productModel = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        imageurl: product.imageurl,
        price: product.price,
      );

      final result = await remoteDataSource.addproduct(productModel);

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model.toEntity()),
      );
    } on Failure {
      return const Left(Failure('Server Error'));
    } on SocketException {
      return const Left(Failure('Connection Error'));
    } }
    else 
    {
      return const Left(Failure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, ProductEntitiy>> deleteproduct(String productId) async {
  final isConnected = await network_info.isConnected;
  if (isConnected == true)
{try {
      final result = await remoteDataSource.deleteproduct(productId);

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model.toEntity()),
      );
    } on Failure {
      return const Left(Failure('Server Error'));
    } on SocketException {
      return const Left(Failure('Connection Error'));
    } }
    else
    {
      return const Left(Failure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntitiy>>> getAllProduct() async {
    // final isConnected = await network_info.isConnected;
    if (await network_info.isConnected)
   { try {
      final result = await remoteDataSource.getAllProducts();

      return result.fold(
        (failure) => Left(failure),
        (models) => Right(ProductModel.listToEntity(models)), // Use listToEntity here
      );
    } on Failure {
      return const Left(Failure('Server Error'));
    } on SocketException {
      return const Left(Failure('Connection Error'));
    } }
    else
    {
      return const Left(Failure('No Internet  Connection'));
    }
  }

  @override
  Future<Either<Failure, ProductEntitiy>> getProductById(String productId) async {
   final isConnected = await network_info.isConnected;
    if (isConnected == true)

   { try {
      final result = await remoteDataSource.getProductById(productId);

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model.toEntity()),
      );
    } on Failure {
      return const Left(Failure('Server Error'));
    } on SocketException {
      return const Left(Failure('Connection Error'));
    } }
    else
    {
      return const Left(Failure('No Internet Connection'));
    }
    
  }

  @override
  Future<Either<Failure, ProductEntitiy>> updateproduct(String productId,ProductModel productModel) async {
    final isConnected = await network_info.isConnected;
    if (isConnected == true)
{    try {
      final result = await remoteDataSource.updateproduct(productId,productModel);

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model.toEntity()),
      );
    } on Failure {
      return const Left(Failure('Server Error'));
    } on SocketException {
      return const Left(Failure('Connection Error'));
    } }
    else
    {
      return const Left(Failure('No Internet Connection'));
    }
  }
}




















// import 'dart:io'; // For SocketException
// import 'package:clean_architecture/core/Network/Network_info.dart';
// import 'package:clean_architecture/core/error/failure.dart';
// import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
// import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';
// import 'package:dartz/dartz.dart';
// import 'package:clean_architecture/features/product/data/data_sources/remote_data_source.dart';
// import 'package:clean_architecture/features/product/data/models/products_models.dart';

// class ProductRepositoryImpl implements ProductRepositories {
//   final RemoteDataSource remoteDataSource;
//   final Network_info networkInfo;
//   ProductRepositoryImpl({required this.remoteDataSource ,required this.networkInfo,
// });

//   @override
//   Future<Either<Failure, ProductEntitiy>> addproduct(ProductEntitiy product) async {
//   if (await networkInfo.isConnected) {
//     try {
//       final productModel = ProductModel(
//         id: product.id,
//         name: product.name,
//         description: product.description,
//         imageurl: product.imageurl,
//         price: product.price,
//       );

//       final result = await remoteDataSource.addproduct(productModel);

//       return result.fold(
//         (failure) => Left(failure),
//         (model) => Right(model.toEntity()),
//       );
//     } on ServerFailure {
//       return const Left(ServerFailure('Server Error'));
//     } on SocketException {
//       return const Left(ConnectionFailure('Connection Error'));
//     } catch (e) {
//       // Catch any other exceptions
//       return const Left(ServerFailure('Unexpected Error'));
//     }
//   } else {
//     return const Left(ConnectionFailure('No Internet Connection'));
//   }
// }

    
// @override
// Future<Either<Failure, ProductEntitiy>> deleteproduct(int productId) async {
//   if (await networkInfo.isConnected) {
//     try {
//       final result = await remoteDataSource.deleteproduct(productId);

//       return result.fold(
//         (failure) => Left(failure),
//         (model) => Right(model.toEntity()),
//       );
//     } on ServerFailure {
//       return const Left(ServerFailure('Server Error'));
//     } on SocketException {
//       return const Left(ConnectionFailure('Connection Error'));
//     } catch (e) {
//       // Catch any other exceptions
//       return const Left(ServerFailure('Unexpected Error'));
//     }
//   } else {
//     return const Left(ConnectionFailure('No Internet Connection'));
//   }
// }

//    @override
// Future<Either<Failure, List<ProductEntitiy>>> getAllProduct() async {
//   if (await networkInfo.isConnected) {
//     try {
//       final result = await remoteDataSource.getAllProducts();

//       return result.fold(
//         (failure) => Left(failure),
//         (models) => Right(ProductModel.listToEntity(models)), // Use listToEntity here
//       );
//     } on ServerFailure {
//       return const Left(ServerFailure('Server Error'));
//     } on SocketException {
//       return const Left(ConnectionFailure('Connection Error'));
//     } catch (e) {
//       // Catch any other exceptions
//       return const Left(ServerFailure('Unexpected Error'));
//     }
//   } else {
//     return const Left(ConnectionFailure('No Internet Connection'));
//   }
// }

// @override
// Future<Either<Failure, ProductEntitiy>> getProductById(int productId) async {
//   if (await networkInfo.isConnected) {
//     try {
//       final result = await remoteDataSource.getProductById(productId);

//       return result.fold(
//         (failure) => Left(failure),
//         (model) => Right(model.toEntity()),
//       );
//     } on ServerFailure {
//       return const Left(ServerFailure('Server Error'));
//     } on SocketException {
//       return const Left(ConnectionFailure('Connection Error'));
//     } catch (e) {
//       // Catch any other exceptions
//       return const Left(ServerFailure('Unexpected Error'));
//     }
//   } else {
//     return const Left(ConnectionFailure('No Internet Connection'));
//   }
// }

// @override
// Future<Either<Failure, ProductEntitiy>> updateproduct(int productId) async {
//   if (await networkInfo.isConnected) {
//     try {
//       final result = await remoteDataSource.updateproduct(productId);

//       return result.fold(
//         (failure) => Left(failure),
//         (model) => Right(model.toEntity()),
//       );
//     } on ServerFailure {
//       return const Left(ServerFailure('Server Error'));
//     } on SocketException {
//       return const Left(ConnectionFailure('Connection Error'));
//     } catch (e) {
//       // Catch any other exceptions
//       return const Left(ServerFailure('Unexpected Error'));
//     }
//   } else {
//     return const Left(ConnectionFailure('No Internet Connection'));
//   }
// }

// }
