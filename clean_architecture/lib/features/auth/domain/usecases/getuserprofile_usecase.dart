import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
import 'package:clean_architecture/features/auth/domain/repository/user_repositories.dart';
import 'package:dartz/dartz.dart';
class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, User>> getUserProfile() {
    return repository.getUserProfile();
  }
}