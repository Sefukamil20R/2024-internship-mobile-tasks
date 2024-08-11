import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/domain/usecases/delete_product.dart'; 

import '../../mocks.mocks.dart'; 

void main() {
  late MockProductRepositories mockProductRepositories;
  late DeleteProductusecase deleteProductUseCase;

  setUp(() {
    mockProductRepositories = MockProductRepositories();
    deleteProductUseCase = DeleteProductusecase(mockProductRepositories);
  });

  final Id = "1";
  final product_3 = ProductEntitiy(
    id: Id,
    name: 'Laptop',
    description: 'Dell XPS',
    imageurl: 'http://example.com/laptop.jpg',
    price: 1200,
  );

  group('DeleteProductUseCase', () {
    test('should return ProductEntitiy when the repository call is successful', () async {
      // arrange
      when(mockProductRepositories.deleteproduct(Id))
          .thenAnswer((_) async => Right(product_3));

      // act
      final result = await deleteProductUseCase.deleteproduct(Id);

      // assert
      expect(result, Right(product_3));
      verify(mockProductRepositories.deleteproduct(Id));
      verifyNoMoreInteractions(mockProductRepositories);
    });

    test('should return Failure when the repository call fails', () async {
      // arrange
      const failure = Failure('Failed to delete product');
      when(mockProductRepositories.deleteproduct(Id))
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await deleteProductUseCase.deleteproduct(Id);

      // assert
      expect(result, const Left(failure));
      verify(mockProductRepositories.deleteproduct(Id));
      verifyNoMoreInteractions(mockProductRepositories);
    });
  });
}
