import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/domain/usecases/update_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.mocks.dart';

// class MockProductRepositories extends Mock implements ProductRepositories {}

void main() {
  late UpdateProductusecase updateProductUseCase;
  late MockProductRepositories mockProductRepositories;

  setUp(() {
    mockProductRepositories = MockProductRepositories();
    updateProductUseCase = UpdateProductusecase(mockProductRepositories);
  });

  final String id = '1';
  final ProductModel productModel = ProductModel(
    id: '1',
    name: 'Laptop',
    description: 'Dell XPS',
    imageurl: 'http://example.com/laptop.jpg',
    price: 1200,
  );
  final ProductEntitiy productEntity = ProductEntitiy(
    id: '1',
    name: 'Laptop',
    description: 'Dell XPS',
    imageurl: 'http://example.com/laptop.jpg',
    price: 1200,
  );

  test('should return ProductEntity when the repository call is successful', () async {
    // arrange
    when(mockProductRepositories.updateproduct(id, productModel))
        .thenAnswer((_) async => Right(productEntity));

    // act
    final result = await updateProductUseCase.updateproduct(id,productModel);

    // assert
    expect(result, Right(productEntity));
    verify(mockProductRepositories.updateproduct(id, productModel));
    verifyNoMoreInteractions(mockProductRepositories);
  });

  test('should return Failure when the repository call fails', () async {
    // arrange
    when(mockProductRepositories.updateproduct(id, productModel))
        .thenAnswer((_) async => Left(Failure('Some error')));

    // act
    final result = await updateProductUseCase.updateproduct(id, productModel);

    // assert
    expect(result, Left(Failure('Some error')));
    verify(mockProductRepositories.updateproduct(id, productModel));
    verifyNoMoreInteractions(mockProductRepositories);
  });
}
