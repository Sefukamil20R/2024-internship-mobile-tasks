import 'package:dartz/dartz.dart';
// import 'package:your_project/core/error/failure.dart';
// import 'package:your_project/features/your_feature/domain/entities/your_entity.dart';
// import 'package:your_project/features/your_feature/domain/repositories/your_repository.dart';

class YourUseCaseName {
  final YourRepository yourRepository;

  YourUseCaseName(this.yourRepository);

  Future<Either<Failure, YourEntity>> execute(YourEntity entity) {
    return yourRepository.someMethod(entity);
  }
}












// The Either type from the dartz package is used to 
//handle cases where a function can either return a value of type Right 
//or an error of type Left.
// dartz.dart: Provides the Either type used for functional error handling, 
//encapsulating either a success (ProductEntitiy) or a failure (Failure).
// Left: Represents a Failure, which indicates an error or failure in the operation.
// Right: Represents a ProductEntitiy, which is the successful result of adding a product