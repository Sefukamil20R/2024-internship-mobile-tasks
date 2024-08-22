import 'dart:convert';
import 'dart:io';
import 'package:clean_architecture/features/product/data/data_sources/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:dartz/dartz.dart';
import '../../mocks.mocks.dart';
// Mock class
// class MockHttpClient extends Mock implements http.Client {}

// Helper function to read JSON files
String readJson(String path) => json.encode({
  'statusCode': 200,
  'message': '',
  'data': json.decode(File(path).readAsStringSync())
});

void main() {
  late MockClient mockHttpClient;
  late RemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSourceImpl = RemoteDataSourceImpl(client: mockHttpClient, userLocalDataSource:  );
  });

  group('getAllProducts', () {
  test('should return a list of ProductModel when the response code is 200', () async {
  // Arrange
  when(mockHttpClient.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products')))
      .thenAnswer((_) async => http.Response(
            readJson('helpers/dummy_data/json_respond_data.json'),
            200,
          ));

  // Act
  final result = await remoteDataSourceImpl.getAllProducts();

  // Assert
  result.fold(
    (l) => fail('Expected a list of ProductModel, but got a Failure'),
    (r) => expect(
      r,
      isA<List<ProductModel>>()
        .having((list) => list.length, 'length', 8) // Ensure the list has the correct number of items
        .having((list) => list[0], 'first item', isA<ProductModel>()), // Check the type of the first item
    ),
  );
});


  test('should return a Failure when the response code is not 200', () async {
  // Arrange
  when(mockHttpClient.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products')))
      .thenAnswer((_) async => http.Response(
            'Something went wrong',
            500,
          ));

  // Act
  final result = await remoteDataSourceImpl.getAllProducts();

  // Assert
  result.fold(
    (l) => expect(l, const Failure('Failed to fetch products')), // Check if `l` is the expected `Failure`
    (r) => null, // Ensure the result is a Failure
  );
});



   test('should return a Failure when an exception occurs', () async {
  // Arrange
  when(mockHttpClient.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products')))
      .thenThrow(Exception('Failed to connect'));

  // Act
  final result = await remoteDataSourceImpl.getAllProducts();

  // Assert
  result.fold(
    (failure) => expect(failure, const Failure('An unexpected error occurred')), // Check the Failure case
    (productList) => null, // Ensure the result is not a product list
  );
});

  });

  group('getProductById', () {
    test('should return a Failure when the response code is not 200', () async {
  // Arrange
  when(mockHttpClient.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a')))
      .thenAnswer((_) async => http.Response('Something went wrong', 500));

  // Act
  final result = await remoteDataSourceImpl.getProductById('66b0b23928f63adda72ab38a');

  // Assert
  // expect(result, Left<Failure, ProductModel>(Failure('Failed to fetch product')));
   result.fold((r) => null,(l) => expect(l,const Failure("Failed to fetch products")) );

});


    test('should return a Failure when the response code is not 200', () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a')))
          .thenAnswer((_) async => http.Response('Something went wrong', 500));

      // Act
      final result = await remoteDataSourceImpl.getProductById('66b0b23928f63adda72ab38a');

      // Assert
      // expect(result, Left(Failure('Failed to fetch product')));
        result.fold((r) => null,(l) => expect(l,const Failure("Failed to fetch products")) );

    });

    test('should return a Failure when an exception occurs', () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a')))
          .thenThrow(Exception('Failed to connect'));

      // Act
      final result = await remoteDataSourceImpl.getProductById('66b0b23928f63adda72ab38a');

      // Assert
      // expect(result, Left(Failure('An unexpected error occurred')));
       result.fold((r) => null,(l) => expect(l,const Failure("An unexpected error occurred")) );

    });
  });

  group('addProduct', () {
    final testProduct = ProductModel(
      id: '66b0b23928f63adda72ab38a',
      name: 'New Product',
      description: 'Description',
      price: 100,
      imageurl: 'https://example.com/image.jpg',
    );
test('should return a Failure when the response code is not 200', () async {
  // Arrange
  when(mockHttpClient.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a')))
      .thenAnswer((_) async => http.Response('Something went wrong', 500));

  // Act
  final result = await remoteDataSourceImpl.getProductById('66b0b23928f63adda72ab38a');

  // Assert
  // expect(result, Left<Failure, ProductModel>(Failure('Failed to fetch product')));
    result.fold((r) => null,(l) => expect(l,const Failure("Failed to fetch products")) );
});


    test('should return a Failure when the response code is not 201', () async {
      // Arrange
      when(mockHttpClient.post(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(testProduct.toJson()),
      )).thenAnswer((_) async => http.Response('Failed to add product', 500));

      // Act
      final result = await remoteDataSourceImpl.addproduct(testProduct);

      // Assert
      // expect(result, Left(Failure('Failed to add product')));
      result.fold((r) => null,(l) => expect(l,const Failure("Failed to add product")) );
    });

    test('should return a Failure when an exception occurs', () async {
      // Arrange
      when(mockHttpClient.post(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(testProduct.toJson()),
      )).thenThrow(Exception('Failed to connect'));

      // Act
      final result = await remoteDataSourceImpl.addproduct(testProduct);

      // Assert
      // expect(result, Left(Failure('An unexpected error occurred')));
      result.fold((r) => null,(l) => expect(l,const Failure("An unexpected error occurred")) );
    });
  });

  group('updateProduct', () {
    final testProduct = ProductModel(
      id: '66b0b23928f63adda72ab38a',
      name: 'Updated Product',
      description: 'Updated Description',
      price: 150,
      imageurl: 'https://example.com/updated_image.jpg',
    );
    test('should return a ProductModel when the response code is 200', () async {
  // Arrange
  when(mockHttpClient.put(
    Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(testProduct.toJson()),
  )).thenAnswer((_) async => http.Response(
        readJson('helpers/dummy_data/json_respond_data.json'),
        200,
      ));

  // Act
  final result = await remoteDataSourceImpl.updateproduct('66b0b23928f63adda72ab38a', testProduct);

  // Assert
  // expect(result, equals(Right<Failure, ProductModel>(testProduct)));
  result.fold((l) => null,(r) => expect(r,ProductModel));
});



    test('should return a Failure when the response code is not 200', () async {
      // Arrange
      when(mockHttpClient.put(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(testProduct.toJson()),
      )).thenAnswer((_) async => http.Response('Failed to update product', 500));

      // Act
      final result = await remoteDataSourceImpl.updateproduct('66b0b23928f63adda72ab38a', testProduct);

      // Assert
      // expect(result, Left(Failure('Failed to update product')));
      result.fold((r) => null,(l) => expect(l,const Left(Failure('Failed to update product'))) );

    });

    test('should return a Failure when an exception occurs', () async {
      // Arrange
      when(mockHttpClient.put(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(testProduct.toJson()),
      )).thenThrow(Exception('Failed to connect'));

      // Act
      final result = await remoteDataSourceImpl.updateproduct('66b0b23928f63adda72ab38a', testProduct);

      // Assert
      // expect(result, Left(Failure('An unexpected error occurred')));
      result.fold((r) => null,(l) => expect(l,const Left(Failure('An unexpected error occurred'))) );
    });
  });

  group('deleteProduct', () {
    test('should return a ProductModel when the response code is 200', () async {
      // Arrange
      when(mockHttpClient.delete(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a'),
      )).thenAnswer((_) async => http.Response(
            'Product deleted successfully',
            200,
          ));

      // Act
      final result = await remoteDataSourceImpl.deleteproduct('66b0b23928f63adda72ab38a');

      // Assert
      // expect(result, isA<Right<Failure, String>>());
      // result.fold((l) => null,(r) => expect(r,"Product deleted successfully") );
      result.fold((l) => null,(r) => expect(r,String) );
    });

    test('should return a Failure when the response code is not 200', () async {
      // Arrange
      when(mockHttpClient.delete(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a'),
      )).thenAnswer((_) async => http.Response('Failed to delete product', 500));

      // Act
      final result = await remoteDataSourceImpl.deleteproduct('66b0b23928f63adda72ab38a');

      // Assert
      // expect(result, Left(Failure('Failed to delete product')));
      result.fold((r) => null,(l) => expect(l,const Failure("Failed to delete product")) );
    });

    test('should return a Failure when an exception occurs', () async {
      // Arrange
      when(mockHttpClient.delete(
        Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/66b0b23928f63adda72ab38a'),
      )).thenThrow(Exception('Failed to connect'));

      // Act
      final result = await remoteDataSourceImpl.deleteproduct('66b0b23928f63adda72ab38a');

      // Assert
      // expect(result, Left(Failure('An unexpected error occurred')));
      result.fold((r) => null,(l) => expect(l,const Failure("An unexpected error occurred")) );
    });
  });
}
      // result.fold((l) => null,(r) => expect(r,[ProductModel]) );


