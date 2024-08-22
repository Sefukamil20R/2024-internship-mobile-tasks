import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/auth/domain/repository/user_repositories.dart';
import 'package:dartz/dartz.dart';
class LoginUserUseCase {
  final UserRepository repository;

  LoginUserUseCase(this.repository);

  Future<Either<Failure, String>> loginUser(String email, String password) {
    return repository.loginUser(email, password);
  }
}