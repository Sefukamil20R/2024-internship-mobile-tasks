import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/models/products_models.dart';

abstract class LocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getAllProducts();
  Future<Either<Failure, ProductModel>> getProductById(String productId);
  Future<Either<Failure, ProductModel>> addProduct(ProductModel product);
  Future<Either<Failure, ProductModel>> updateProduct(String productId, ProductModel product);
  Future<Either<Failure, ProductModel>> deleteProduct(String productId);
}

const String productCacheKey = 'local_product_data';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  const LocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      final jsonString = sharedPreferences.getString(productCacheKey);
      if (jsonString != null) {
        final List<dynamic> result = json.decode(jsonString);
        final List<ProductModel> products = result.map((json) => ProductModel.fromJson(json)).toList();
        return Right(products);
      } else {
        return Right([]);
      }
    } catch (e) {
      return Left(Failure('Error fetching all products'));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(String productId) async {
    try {
      final jsonString = sharedPreferences.getString(productCacheKey);
      if (jsonString != null) {
        final List<dynamic> result = json.decode(jsonString);
        final products = result.map((json) => ProductModel.fromJson(json)).toList();
        final product = products.firstWhere(
          (product) => product.id == productId,
          orElse: () => throw const Failure('Product not found'),
        );
        return Right(product);
      } else {
        return Left(Failure('Product not found'));
      }
    } catch (e) {
      return Left(Failure('Error fetching product by ID'));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> addProduct(ProductModel product) async {
    try {
      final jsonString = sharedPreferences.getString(productCacheKey);
      List<ProductModel> products = [];
      
      if (jsonString != null) {
        final List<dynamic> result = json.decode(jsonString);
        products = result.map((json) => ProductModel.fromJson(json)).toList();
      }

      products.add(product);
      final updatedJsonString = json.encode(products.map((p) => p.toJson()).toList());
      final success = await sharedPreferences.setString(productCacheKey, updatedJsonString);
      
      if (success) {
        return Right(product);
      } else {
        return Left(Failure('Error adding product'));
      }
    } catch (e) {
      return Left(Failure('Error adding product'));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> updateProduct(String productId, ProductModel product) async {
    try {
      final productsResult = await getAllProducts();
      return productsResult.fold(
        (failure) => Left(failure),
        (productList) async {
          final index = productList.indexWhere((p) => p.id == productId);
          if (index == -1) return Left(Failure('Product not found'));
          
          productList[index] = product;
          final updatedJsonString = json.encode(productList.map((p) => p.toJson()).toList());
          final success = await sharedPreferences.setString(productCacheKey, updatedJsonString);
          
          if (success) {
            return Right(product);
          } else {
            return Left(Failure('Error updating product'));
          }
        },
      );
    } catch (e) {
      return Left(Failure('Error updating product'));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> deleteProduct(String productId) async {
    try {
      final productsResult = await getAllProducts();
      return productsResult.fold(
        (failure) => Left(failure),
        (productList) async {
          final updatedProductList = productList.where((product) => product.id != productId).toList();
          final updatedJsonString = json.encode(updatedProductList.map((p) => p.toJson()).toList());
          final success = await sharedPreferences.setString(productCacheKey, updatedJsonString);
          
          if (success) {
            return Right(ProductModel(id: productId, name: '', price: 0, description: '', imageurl: '')); // Adjust as needed
          } else {
            return Left(Failure('Error deleting product'));
          }
        },
      );
    } catch (e) {
      return Left(Failure('Error deleting product'));
    }
  }
}
