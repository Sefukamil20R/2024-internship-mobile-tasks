import 'package:clean_architecture/features/product/domain/usecases/get_allproduct.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';

import '../../mocks.mocks.dart';  

void main()
{
  late MockProductRepositories mockProductRepositories;
  late GetAllproductusecase getAllProductUseCase;

  setUp(() {
    mockProductRepositories = MockProductRepositories();
    getAllProductUseCase = GetAllproductusecase(mockProductRepositories);
  });
  final List<ProductEntitiy> products = [
    ProductEntitiy(
      id: "1",
      name: 'Laptop',
      description: 'Dell XPS',
      imageurl: 'http://example.com/laptop.jpg',
      price: 1200,
    ),
    ProductEntitiy(
      id:" 2",
      name: 'Phone',
      description: 'iPhone 12',
      imageurl: 'http://example.com/phone.jpg',
      price: 999,
    ),
  ];
  group("GetAllProductUseCase",()
  {test("should return a list of ProductEntitiy when the repository call is successful", ()async
    {
      // arrange
      when(mockProductRepositories.getAllProduct()).thenAnswer((_)async => Right(products));
      // act
      final result = await getAllProductUseCase.getAllproduct();
      // assert
      expect(result, Right(products));
          

    });
    test("should return Failure when the repository call fails", ()async 
    {
      // arrange
      const failure = Failure("Server Error");
      when(mockProductRepositories.getAllProduct()).thenAnswer((_)async => Left(failure));
      // act
      final result = await getAllProductUseCase.getAllproduct();
      // assert
      expect(result, const Left(failure));
    });



  }
    
    
    
    );
}


























// void main() {
//   late MockProductRepositories mockProductRepositories;
//   late GetAllproductusecase getAllProductUseCase;

//   setUp(() {
//     mockProductRepositories = MockProductRepositories();
//     getAllProductUseCase = GetAllproductusecase(mockProductRepositories);
//   });

//   final List<ProductEntitiy> products = [
//     ProductEntitiy(
//       id: 1,
//       name: 'Laptop',
//       description: 'Dell XPS',
//       imageurl: 'http://example.com/laptop.jpg',
//       price: 1200,
//     ),
//     ProductEntitiy(
//       id: 2,
//       name: 'Phone',
//       description: 'iPhone 12',
//       imageurl: 'http://example.com/phone.jpg',
//       price: 999,
//     ),
//   ];

//   group('GetAllProductUseCase', () {
//     test('should return a list of ProductEntitiy when the repository call is successful', () async {
//       // arrange
//       when(mockProductRepositories.getAllProducts())
//           .thenAnswer((_) async => Right(products));

//       // act
//       final result = await getAllProductUseCase.getAllproduct();

//       // assert
//       expect(result, Right(products));
//       verify(mockProductRepositories.getAllProducts());
//       verifyNoMoreInteractions(mockProductRepositories);
//     });

//     test('should return Failure when the repository call fails', () async {
//       // arrange
//       final failure = Failure('Server error');
//       when(mockProductRepositories.getAllProducts())
//           .thenAnswer((_) async => Left(failure));

//       // act
//       final result = await getAllProductUseCase.getAllproduct();

//       // assert
//       expect(result, Left(failure));
//       verify(mockProductRepositories.getAllProducts());
//       verifyNoMoreInteractions(mockProductRepositories);
//     });
//   });
// }
