import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/auth/data/models/userModel_nopassword.dart';
import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
import 'package:dartz/dartz.dart';
abstract class UserRepository {
  Future<Either<Failure, User>> registerUser(User user);
  Future<Either<Failure, String>> loginUser(String email, String password);
  Future<Either<Failure, User>> getUserProfile();
  Future<Either<Failure, void>>logout();
}
