import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:clean_architecture/features/product/domain/usecases/update_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.mocks.dart';  
void main() {
  late MockProductRepositories mockProductRepositories;
  late UpdateProductusecase updateProductUseCase;

  setUp(() {
    mockProductRepositories = MockProductRepositories();
    updateProductUseCase = UpdateProductusecase(mockProductRepositories);
  });

   int Id = 1;
   ProductEntitiy product_2 = ProductEntitiy(
    id: 1,
    name: 'Laptop',
    description: 'Dell XPS',
    imageurl: 'http://example.com/laptop.jpg',
    price: 1200,
  );

  group('UpdateProductUseCase', () {
    test('should return ProductEntitiy when the repository call is successful', () async {
      // arrange
      when(mockProductRepositories.updateproduct(Id))
          .thenAnswer((_) async => Right(product_2));

      // act
      final result = await updateProductUseCase.updateproduct(Id);

      // assert
      expect(result, Right(product_2));
      verify(mockProductRepositories.updateproduct(Id));
      verifyNoMoreInteractions(mockProductRepositories);
    });

    test('should return Failure when the repository call fails', () async {
      // arrange
      final failure = Failure('Update failed');
      when(mockProductRepositories.updateproduct(Id))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await updateProductUseCase.updateproduct(Id);

      // assert
      expect(result, Left(failure));
      verify(mockProductRepositories.updateproduct(Id));
      verifyNoMoreInteractions(mockProductRepositories);
    });
  });
}
