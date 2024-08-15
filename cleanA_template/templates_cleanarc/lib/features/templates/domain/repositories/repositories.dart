import 'package:dartz/dartz.dart';
// import 'package:your_project/core/error/failure.dart';
// import 'package:your_project/features/your_feature/domain/entities/your_entity.dart';
// import 'package:your_project/features/your_feature/data/models/your_model.dart';

abstract class YourRepository {
  Future<Either<Failure, List<YourEntity>>> getAllItems();
  Future<Either<Failure, YourEntity>> getItemById(String itemId);
  Future<Either<Failure, YourEntity>> addItem(YourEntity item);
  Future<Either<Failure, YourEntity>> updateItem(String itemId, YourModel item);
  Future<Either<Failure, YourEntity>> deleteItem(String itemId);
}


// // About Future 
// A Future represents a value that will be available at some point in the future. 
// It’s used to handle asynchronous operations in Dart, such as data fetching, file reading, or any operation that takes time to complete.
// Future allows you to write asynchronous code, which means your program can continue running while waiting for an operation to complete.
// Completion: A Future can complete in one of two ways:
// With a value: This is represented by Future.value(result).
// With an error: This is represented by Future.error(error).