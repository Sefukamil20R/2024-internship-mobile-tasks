import 'package:clean_architecture/features/product/domain/usecases/get_specproduct.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';


import '../../mocks.mocks.dart'; 

void main() {
  late MockProductRepositories mockProductRepositories;
  late GetSpecproductsusecase getSpecProductUseCase;

  setUp(() {
    mockProductRepositories = MockProductRepositories();
    getSpecProductUseCase = GetSpecproductsusecase(mockProductRepositories);
  });

  final Id =" 1";
  final testProduct = ProductEntitiy(
    id: Id,
    name: 'Laptop',
    description: 'Dell XPS',
    imageurl: 'http://example.com/laptop.jpg',
    price: 1200,
  );

  group('GetSpecProductUseCase', () {
    test('should return ProductEntitiy when the repository call is successful', () async {
      // arrange
      when(mockProductRepositories.getProductById(Id))
          .thenAnswer((_) async => Right(testProduct));

      // act
      final result = await getSpecProductUseCase.GetSpecproduct(Id);

      // assert
      expect(result, Right(testProduct));
      verify(mockProductRepositories.getProductById(Id));
      verifyNoMoreInteractions(mockProductRepositories);
    });

    test('should return Failure when the repository call fails', () async {
      // arrange
      const failure = Failure('Product not found');
      when(mockProductRepositories.getProductById(Id))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await getSpecProductUseCase.GetSpecproduct(Id);

      // assert
      expect(result, Left(failure));
      verify(mockProductRepositories.getProductById(Id));
      verifyNoMoreInteractions(mockProductRepositories);
    });
  });
}
