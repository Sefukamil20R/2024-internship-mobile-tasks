//logoutuser
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/auth/domain/repository/user_repositories.dart';
import 'package:dartz/dartz.dart';
class LogoutUserUseCase 
{
  final UserRepository userRepository;
  
  LogoutUserUseCase(this.userRepository);

  Future<Either<Failure,void>>logout() {
    return userRepository.logout();
  }
}