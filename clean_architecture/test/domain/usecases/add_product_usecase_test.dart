import 'package:clean_architecture/features/product/domain/usecases/add_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';

import '../../mocks.mocks.dart';


void main() {
  late MockProductRepositories mockProductRepositories;
  late AddProductUseCase addProductUseCase;

  setUp(() {
    mockProductRepositories = MockProductRepositories();
    addProductUseCase = AddProductUseCase(mockProductRepositories);
  });

  final product_One = ProductEntitiy(
    id: 1,
    name: 'Laptope',
    description: 'Dell',
    imageurl: 'http://laptope.com/image.jpg',
    price: 100,
  );

  group('AddProductUseCase', () {
    test('should return ProductEntitiy when the repository call is successful', () async {
      // arrange
      when(mockProductRepositories.addproduct(product_One))
          .thenAnswer((_) async => Right(product_One));

      // act
      final result = await addProductUseCase.addProduct(product_One);

      // assert
      expect(result, Right(product_One));
      verify(mockProductRepositories.addproduct(product_One));
      verifyNoMoreInteractions(mockProductRepositories);
    });

    test('should return Failure when the repository call fails', () async {
      // arrange
      final failure = Failure('Server error');
      when(mockProductRepositories.addproduct(product_One))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await addProductUseCase.addProduct(product_One);

      // assert
      expect(result, Left(failure));
      verify(mockProductRepositories.addproduct(product_One));
      verifyNoMoreInteractions(mockProductRepositories);
    });
  });
}



// About Flutter_Test
// The flutter_test package provides the necessary tools and utilities for writing and running tests
// in Flutter applications.
//flutter_test is a wrapper around the Dart testing framework (package:test/test.dart) 
//and provides additional functionality specific to Flutter.
// It enables you to write unit tests, widget tests, and integration tests 
//for your Flutter application.
// test(): Defines a test case. You write your test logic inside the callback function.
// group(): Organizes multiple related tests together. It helps in grouping related test cases for better structure and readability.
// setUp(): Sets up common test dependencies and state before each test case runs. It’s useful for initializing objects or state that multiple tests will use.
// tearDown(): Cleans up after each test case runs, if needed.
// expect(): Asserts that a given value matches an expected result. It’s used to verify that your code behaves as expected.
// the reason why we are importing flutter_test is becuase it Provides utility functions and classes required for writing and managing your tests, like expect(), setUp(), and group().
// example code 
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   // Set up any common resources or state
//   setUp(() {
//     // Initialization before each test
//   });

//   // Group related tests together
//   group('Example Test Group', () {
//     // Define a test case
//     test('should do something', () {
//       // Arrange: Set up the conditions for the test
//       // Act: Execute the functionality to be tested
//       // Assert: Verify that the results match the expectations
//       expect(1 + 1, equals(2));
//     });
//   });
// }
// About Mock
// we dont care about API so we want to check when usecase call repositories the usecase can get the all the infos 
// we dont have to touch the exact remote like when we call one of the methods to test lets say delete it will delete the remote data 
// so we dont have delte the datas for testing  so we save the copies to mock then then we dont know if the Api sends the data or not so we write the 
// the conditions in the arrange part we call the method in mock repository then we will give data to reply so if usecase gets the data from the mock we set the right(given) so 
// in the act part we will run the functionality to be tested so we will call the usecase method and pass the data to the method then we will get the result
// then in the expect part we will check if the result is equal to the data we have given to the mock repository if it is equal then the test will pass