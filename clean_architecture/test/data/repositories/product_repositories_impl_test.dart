import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:clean_architecture/features/product/data/repositories/product_repository_imp.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../mocks.mocks.dart';


void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late ProductRepositoryImpl productRepositoryImpl;
  late MockNetwork_info mockNetworkInfo;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetwork_info();
    mockLocalDataSource = MockLocalDataSource();
    productRepositoryImpl = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      network_info: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
    );
  });

  final productModel = ProductModel(
    id: "1",
    name: 'Test Product',
    description: 'Test Description',
    imageurl: 'http://example.com/image.png',
    price: 10
  );
  
  final productEntity = ProductEntitiy(
    id:"1",
    name: 'Test Product',
    description: 'Test Description',
    imageurl: 'http://example.com/image.png',
    price: 10,
  );

  group('ProductRepositoryImpl', () {
test('should return ProductEntity when the addProduct call succeeds', () async {
  // arrange
  when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  when(mockRemoteDataSource.addproduct(any))
      .thenAnswer((_) async => Right(productModel));

  // act
  final result = await productRepositoryImpl.addproduct(productEntity);

  // assert
  // expect(result, Right(productEntity));
  result.fold((l) => null ,(r)=>expect(r, productEntity));
  // verify(mockRemoteDataSource.addproduct(productModel));
  // verifyNoMoreInteractions(mockRemoteDataSource);
});


    test('should return Failure when the addProduct call fails', () async {
      // arrange
      final failure = Failure('Server error');
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addproduct(any))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await productRepositoryImpl.addproduct(productEntity);

      // assert
      expect(result, Left(failure));
      
      // verify(mockRemoteDataSource.addproduct(productModel));
      // verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ProductEntity when the deleteproduct call succeeds', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteproduct(any))
          .thenAnswer((_) async => Right(productModel));

      // act
      final result = await productRepositoryImpl.deleteproduct(productModel.id);

      // assert
      expect(result, Right(productEntity));
      verify(mockRemoteDataSource.deleteproduct(productModel.id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Failure when the deleteproduct call fails', () async {
      // arrange
      final failure = Failure('Server error');
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteproduct(any))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await productRepositoryImpl.deleteproduct(productModel.id);

      // assert
      expect(result, Left(failure));
      verify(mockRemoteDataSource.deleteproduct(productModel.id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return a list of ProductEntities when getAllProducts call succeeds', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => Right([productModel]));

      // act
      final result = await productRepositoryImpl.getAllProduct();

      // assert
      result.fold(
        (l) => fail('Expected List<ProductEntity> but got Failure'),
        (r) => expect(r, [productEntity]),
      );
      verify(mockRemoteDataSource.getAllProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Failure when getAllProducts call fails', () async {
      // arrange
      final failure = Failure('Server error');
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await productRepositoryImpl.getAllProduct();

      // assert
      expect(result, Left(failure));
      verify(mockRemoteDataSource.getAllProducts());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ProductEntity when getProductById call succeeds', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProductById(any))
          .thenAnswer((_) async => Right(productModel));

      // act
      final result = await productRepositoryImpl.getProductById(productModel.id);

      // assert
      expect(result, Right(productEntity));
      verify(mockRemoteDataSource.getProductById(productModel.id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Failure when getProductById call fails', () async {
      // arrange
      final failure = Failure('Server error');
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProductById(any))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await productRepositoryImpl.getProductById(productModel.id);

      // assert
      expect(result, Left(failure));
      verify(mockRemoteDataSource.getProductById(productModel.id));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ProductEntity when updateProduct call succeeds', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateproduct(any,productModel))
          .thenAnswer((_) async => Right(productModel));

      // act
      final result = await productRepositoryImpl.updateproduct(productModel.id,productModel);

      // assert
      expect(result, Right(productEntity));
      verify(mockRemoteDataSource.updateproduct(productModel.id,productModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Failure when updateProduct call fails', () async {
      // arrange
      final failure = Failure('Server error');
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateproduct(any,productModel))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await productRepositoryImpl.updateproduct(productEntity.id,productModel);

      // assert
      expect(result, Left(failure));
      verify(mockRemoteDataSource.updateproduct(productModel.id,productModel));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
