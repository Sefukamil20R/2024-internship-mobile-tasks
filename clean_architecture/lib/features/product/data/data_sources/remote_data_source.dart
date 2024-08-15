import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:clean_architecture/core/constant/constants.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';

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
      print('${response.statusCode }sefinaaa');
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
      return  Left(Failure(' An unexpected error occurred $e'));
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
    // Load the asset as bytes (you can replace this with actual image picking logic)
    File imageFile = File(product.imageurl);
    List<int> imageBytes = await imageFile.readAsBytes();


    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.baseUrl), // Assuming this is the correct endpoint
    );

    request.fields.addAll({
      'name': product.name,
      'description': product.description,
      'price': product.price.toString(), // Ensure price is sent as a string
    });

    // Convert the bytes to MultipartFile and add to the request
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'fg.jpg',
      contentType: MediaType('image', 'jpeg'),
    ));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> data = json.decode(responseBody)['data'];

      final ProductModel newProduct = ProductModel.fromJson(data);
      return Right(newProduct);
    } else {
      return Left(Failure('Failed to add product: ${response.reasonPhrase}'));
    }
  } catch (e) {
    return Left(Failure('Error during addProduct: $e'));
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
        return Right(ProductModel.fromJson({})); 
      } else {
        return const Left(Failure('Failed to delete product'));
      }
    } catch (e) {
      return const Left(Failure('An unexpected error occurred'));
    }
  }
}
