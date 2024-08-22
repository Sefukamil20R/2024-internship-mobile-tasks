import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
import 'package:clean_architecture/features/auth/domain/repository/user_repositories.dart';
import 'package:dartz/dartz.dart';
class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, User>> registerUser(User user) {
    return repository.registerUser(user);
    
  }
}