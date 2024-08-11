import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clean_architecture/core/constant/constants.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, List<ProductModel>>> getAllProducts();
  Future<Either<Failure, ProductModel>> getProductById(String productId);
  Future<Either<Failure, ProductModel>> addproduct(ProductModel product);
  Future<Either<Failure, ProductModel>> updateproduct(String productId, ProductModel product);
  Future<Either<Failure, ProductModel>> deleteproduct(String productId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});
  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      final http.Response response = await http.get(Uri.parse(Urls.baseUrl));
      // print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final List<dynamic> data = responseBody['data'];

        final List<ProductModel> products = data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Right(products);
      } else {
        return const Left(Failure('Failed to fetch products'));
      }
    } catch (e) {
      return const Left(Failure(' An unexpected error occurred'));
    }
  }
@override
Future<Either<Failure, ProductModel>> getProductById(String productId) async {
  try {
    final http.Response response = await client.get(Uri.parse('${Urls.baseUrl}/$productId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final Map<String, dynamic> data = responseBody['data'];

      final ProductModel product = ProductModel.fromJson(data);
      return Right(product);
    } else {
      return const Left(Failure('Failed to fetch product'));
    }
  } catch (e) {
    return const Left(Failure('An unexpected error occurred'));
  }
}


  @override
  Future<Either<Failure, ProductModel>> addproduct(ProductModel product) async {
    try {
      final response = await http.post(
        Uri.parse(Urls.baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final Map<String, dynamic> data = responseBody['data'];

        final ProductModel newProduct = ProductModel.fromJson(data);
        return Right(newProduct);
      } else {
        return const Left(Failure('Failed to add product'));
      }
    } catch (e) {
      return const Left(Failure('An unexpected error occurred'));
    }
  }
@override
Future<Either<Failure, ProductModel>> updateproduct(String productId, ProductModel product) async {
  try {
    final response = await client.put(
      Uri.parse('${Urls.baseUrl}/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final Map<String, dynamic> data = responseBody['data'];

      final ProductModel updatedProduct = ProductModel.fromJson(data);
      return Right(updatedProduct);
    } else {
      return const Left(Failure('Failed to update product'));
    }
  } catch (e) {
    return const Left(Failure('An unexpected error occurred'));
  }
}


  @override
  Future<Either<Failure, ProductModel>> deleteproduct(String productId) async {
    try {
      final response = await http.delete(Uri.parse('${Urls.baseUrl}/$productId'));

      if (response.statusCode == 200) {
        // Assuming the response body is empty or contains a success message
        return Right(ProductModel.fromJson({})); // Adjust if needed
      } else {
        return const Left(Failure('Failed to delete product'));
      }
    } catch (e) {
      return const Left(Failure('An unexpected error occurred'));
    }
  }
}
