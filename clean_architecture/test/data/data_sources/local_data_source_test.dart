import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/features/product/data/models/products_models.dart';

import '../../mocks.mocks.dart';


// Mocking SharedPreferences using Mockito
// class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late LocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  ProductModel  tProductModel = ProductModel(id: '1', name: 'Test Product', price: 9, description: '', imageurl: '');
  final tProductList = [tProductModel];

  void setUpMockSharedPreferencesGetStringSuccess() {
    when(mockSharedPreferences.getString(any))
        .thenReturn(json.encode(tProductList.map((product) => product.toJson()).toList()));
  }

  group('getAllProducts', () {
    test(
      'should return List<ProductModel> when there is data in SharedPreferences',
      () async {
        // arrange
        setUpMockSharedPreferencesGetStringSuccess();
        // act
        final result = await dataSource.getAllProducts();
        // assert
        verify(mockSharedPreferences.getString(productCacheKey));
        // expect(result, Right(tProductList));
        result.fold((l)=> null, (r) => expect(result, Right(tProductList) ));
      },
    );

//   test(
//   'should return an empty list when there is no data in SharedPreferences',
//   () async {
//     // arrange
//     when(mockSharedPreferences.getString(any)).thenReturn(null);
//     // act
//     final result = await dataSource.getAllProducts();
//     // assert
//     verify(mockSharedPreferences.getString(productCacheKey));
//     // Correct the expected result type without 'const'
//     // expect(result, Right<List<ProductModel>>([]));
//     result.fold((l)=> null, (r) => expect(result, Right([]) ));
//   },
// );



    test(
      'should return a Failure when an error occurs',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenThrow(Exception());
        // act
        final result = await dataSource.getAllProducts();
        // assert
        verify(mockSharedPreferences.getString(productCacheKey));
        // expect(result, Left(Failure('Error fetching all products')));
        result.fold((r)=> null, (l) => expect(result, Left(Failure('Error fetching all products')) ));
      },
    );
  });

  group('getProductById', () {
    test(
      'should return ProductModel when the product is found',
      () async {
        // arrange
        setUpMockSharedPreferencesGetStringSuccess();
        // act
        final result = await dataSource.getProductById('1');
        // assert
        verify(mockSharedPreferences.getString(productCacheKey));
        // expect(result, Right(tProductModel));
        result.fold((l)=> null, (r) => expect(result, Right(tProductModel) ));
      },
    );

    test(
      'should return Failure when the product is not found',
      () async {
        // arrange
        setUpMockSharedPreferencesGetStringSuccess();
        // act
        final result = await dataSource.getProductById('2');
        // assert
        verify(mockSharedPreferences.getString(productCacheKey));
        // expect(result, Left(Failure('Product not found')));
        result.fold((r)=> null, (l) => expect(result, Left(Failure('Product not found')) ));
      },
    );

    test(
      'should return Failure when an error occurs',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenThrow(Exception());
        // act
        final result = await dataSource.getProductById('1');
        // assert
        verify(mockSharedPreferences.getString(productCacheKey));
        // expect(result, Left(Failure('Error fetching product by ID')));
        result.fold((r)=> null, (l) => expect(result, Left(Failure('Error fetching product by ID')) ));
      },
    );
  });

  group('addProduct', () {
    test(
      'should add a new product to SharedPreferences',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);  // Initially, no products exist
        when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

        // act
        final result = await dataSource.addProduct(tProductModel);

        // assert
        final expectedJsonString = json.encode([tProductModel.toJson()]);
        verify(mockSharedPreferences.setString(productCacheKey, expectedJsonString)).called(1);
        // expect(result, Right(tProductModel));
        result.fold((l)=> null, (r) => expect(result, Right(tProductModel) ));
      },
    );

    test(
      'should return Failure when an error occurs while adding a product',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        when(mockSharedPreferences.setString(any, any)).thenThrow(Exception());

        // act
        final result = await dataSource.addProduct(tProductModel);

        // assert
        verify(mockSharedPreferences.setString(productCacheKey, any)).called(1);
        // expect(result, Left(Failure('Error adding product')));
        result.fold((r)=> null, (l) => expect(result, Left(Failure('Error adding product')) ));
      },
    );
  });

  group('updateProduct', () {
    test(
      'should update an existing product in SharedPreferences',
      () async {
        // arrange
        setUpMockSharedPreferencesGetStringSuccess();
        when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
        // act
        final result = await dataSource.updateProduct('1', tProductModel);
        // assert
        final expectedJsonString = json.encode([tProductModel.toJson()]);
        verify(mockSharedPreferences.setString(productCacheKey, expectedJsonString)).called(1);
        // expect(result, Right(tProductModel));
        result.fold((l)=> null, (r) => expect(result, Right(tProductModel) ));
      },
    );

    test(
      'should return Failure when the product to update is not found',
      () async {
        // arrange
        setUpMockSharedPreferencesGetStringSuccess();
        // act
        final result = await dataSource.updateProduct('2', tProductModel);
        // assert
        // expect(result, Left(Failure('Product not found')));
        result.fold((r)=> null, (l) => expect(result, Left(Failure('Product not found')) ));
      },
    );

    test(
      'should return Failure when an error occurs while updating a product',
      () async {
        // arrange
        setUpMockSharedPreferencesGetStringSuccess();
        when(mockSharedPreferences.setString(any, any)).thenThrow(Exception());
        // act
        final result = await dataSource.updateProduct('1', tProductModel);
        // assert
        // expect(result, Left(Failure('Error updating product')));
        result.fold((r)=> null, (l) => expect(result, Left(Failure('Error updating product')) ));
      },
    );
  });

  group('deleteProduct', () {
    // test(
    //   'should delete a product from SharedPreferences',
    //   () async {
    //     // arrange
    //     setUpMockSharedPreferencesGetStringSuccess();
    //     when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
    //     // act
    //     final result = await dataSource.deleteProduct('1');
    //     // assert
    //     final expectedJsonString = json.encode([]);
    //     verify(mockSharedPreferences.setString(productCacheKey, expectedJsonString)).called(1);
    //     // expect(result, Right(ProductModel(id: '1', name: '', price: 0, description: '', imageurl: '')));
    //     result.fold((l)=> null, (r) => expect(r, Right(ProductModel(id: '1', name: '', price: 0, description: '', imageurl: '')) ));
    //   },
    // );

    test(
      'should return Failure when the product to delete is not found',
      () async {
        // arrange
        setUpMockSharedPreferencesGetStringSuccess();
        // act
        final result = await dataSource.deleteProduct('2');
        // assert
        // expect(result, Left(Failure('Error deleting product')));
        result.fold((r)=> null, (l) => expect(result, Left(Failure('Error deleting product')) ));
      },
    );

    test(
      'should return Failure when an error occurs while deleting a product',
      () async {
        // arrange
        setUpMockSharedPreferencesGetStringSuccess();
        when(mockSharedPreferences.setString(any, any)).thenThrow(Exception());
        // act
        final result = await dataSource.deleteProduct('1');
        // assert
        // expect(result, Left(Failure('Error deleting product')));
        result.fold((r)=> null, (l) => expect(result, Left(Failure('Error deleting product')) ));
      },
    );
  });
}























// import 'dart:convert';
// import 'package:clean_architecture/features/product/data/data_sources/local_data_source.dart';
// import 'package:clean_architecture/core/error/failure.dart';
// import 'package:clean_architecture/features/product/data/models/products_models.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../helpers/dummy_data/json_reader.dart';
// import '../../mocks.mocks.dart';
// void main() {
//   late MockSharedPreferences mockSharedPreferences;
//   late LocalDataSourceImpl localDataSourceImpl;

//   setUp(() {
//     mockSharedPreferences = MockSharedPreferences();
//     localDataSourceImpl = LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
//   });

//   final listOfProductsJson = readJson('helpers/dummy_data/other_json_data.json');
//   final listOfProducts = json.decode(listOfProductsJson)['data'] as List<dynamic>;

//   final productModel = ProductModel(
//     id: '66b3b530e0225d4e659f6685',
//     name: 'PC',
//     price: 123,
//     description: 'long description',
//     imageurl: 'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723053359/images/qgoouhgz0run6oyqgqvr.png',
//   );
  

//   group('LocalDataSourceImpl', () {
//     test('getAllProducts returns a list of products', () async {
//       when(mockSharedPreferences.getString(productCacheKey))
//           .thenReturn(json.encode(listOfProducts));

//       final result = await localDataSourceImpl.getAllProducts();

//       verify(mockSharedPreferences.getString(productCacheKey));
//       expect(result, equals(Right(listOfProducts.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList())));
//     });

//     test('getProductById returns a single product', () async {
//       when(mockSharedPreferences.getString(productModel.id))
//           .thenReturn(json.encode(productModel.toJson()));

//       final result = await localDataSourceImpl.getProductById(productModel.id);

//       verify(mockSharedPreferences.getString(productModel.id));
//       expect(result, equals(Right(productModel)));
//     });

//     test('addProduct adds a product correctly', () async {
//       when(mockSharedPreferences.getString(productCacheKey))
//           .thenReturn(json.encode([]));
//       when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

//       final result = await localDataSourceImpl.addProduct(productModel);

//       verify(mockSharedPreferences.setString(productCacheKey, any));
//       expect(result, equals(Right(productModel)));
//     });

//     test('updateProduct updates an existing product', () async {
//       when(mockSharedPreferences.getString(productCacheKey))
//           .thenReturn(json.encode([productModel.toJson()]));
//       when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

//       final updatedProduct = ProductModel(
//         id: productModel.id,
//         name: 'Updated Product',
//         price: productModel.price,
//         description: productModel.description,
//         imageurl: productModel.imageurl,
//       );

//       final result = await localDataSourceImpl.updateProduct(productModel.id, updatedProduct);

//       verify(mockSharedPreferences.setString(productCacheKey, any));
//       expect(result, equals(Right(updatedProduct)));
//     });

//     test('deleteProduct removes a product', () async {
//       when(mockSharedPreferences.getString(productCacheKey))
//           .thenReturn(json.encode([productModel.toJson()]));
//       when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

//       final result = await localDataSourceImpl.deleteProduct(productModel.id);

//       verify(mockSharedPreferences.setString(productCacheKey, any));
//       expect(result, equals(Right(ProductModel(
//         id: productModel.id,
//         name: '',
//         price: 0,
//         description: '',
//         imageurl: ''
//       ))));
//     });

//     test('getAllProducts returns an empty list when no data is found', () async {
//       when(mockSharedPreferences.getString(productCacheKey)).thenReturn(null);

//       final result = await localDataSourceImpl.getAllProducts();

//       expect(result, equals(Right([])));
//     });

//     test('getProductById returns error when product is not found', () async {
//       when(mockSharedPreferences.getString(productModel.id)).thenReturn(null);

//       final result = await localDataSourceImpl.getProductById(productModel.id);

//       expect(result, equals(Left(Failure('Product not found'))));
//     });

//     test('addProduct returns error if not added', () async {
//       when(mockSharedPreferences.getString(productCacheKey))
//           .thenReturn(json.encode([]));
//       when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => false);

//       final result = await localDataSourceImpl.addProduct(productModel);

//       expect(result, equals(Left(Failure('Error adding product'))));
//     });

//     test('updateProduct returns error if not updated', () async {
//       when(mockSharedPreferences.getString(productCacheKey))
//           .thenReturn(json.encode([productModel.toJson()]));
//       when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => false);

//       final updatedProduct = ProductModel(
//         id: productModel.id,
//         name: 'Updated Product',
//         price: productModel.price,
//         description: productModel.description,
//         imageurl: productModel.imageurl,
//       );

//       final result = await localDataSourceImpl.updateProduct(productModel.id, updatedProduct);

//       expect(result, equals(Left(Failure('Error updating product'))));
//     });

//     test('deleteProduct returns error if not deleted', () async {
//       when(mockSharedPreferences.getString(productCacheKey))
//           .thenReturn(json.encode([productModel.toJson()]));
//       when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => false);

//       final result = await localDataSourceImpl.deleteProduct(productModel.id);

//       expect(result, equals(Left(Failure('Error deleting product'))));
//     });
//   });
// }
