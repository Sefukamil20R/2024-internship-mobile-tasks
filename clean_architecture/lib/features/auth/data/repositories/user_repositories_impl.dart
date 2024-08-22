import 'package:clean_architecture/core/Network/Network_info.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/auth/data/data_source/localdatasource.dart';
import 'package:clean_architecture/features/auth/data/data_source/remotedatasource.dart';
import 'package:clean_architecture/features/auth/data/models/userModel_nopassword.dart';
import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
import 'package:clean_architecture/features/auth/domain/repository/user_repositories.dart';

import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
    final Network_info network_info;


  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.network_info,
  });

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async {
    final isConnected = await network_info.isConnected;
    if (isConnected == true) {
      try {
        final accessToken = await remoteDataSource.loginUser(email, password);

        await localDataSource.saveAccessToken(accessToken);

        return Right(accessToken);
      } catch (e) {
        return Left(Failure('An unexpected error occurred'));
      }
    } else {
      return Left(Failure('No Internet Connection'));
    }
  }
    

  @override
  Future<Either<Failure, User>> registerUser(User user) async {
    final isConnected = await network_info.isConnected;
    if (isConnected == true) {
      try {
        final userModel = await remoteDataSource.registerUser(user.name, user.email, user.password ?? '');

        final registeredUser = UsermodelNopassword(
          id: userModel.id,
          name: userModel.name,
          email: userModel.email,
        );

        return Right(registeredUser);
      } catch (e) {
        return Left(Failure('An unexpected error occurred'));
      }
    } else {
      return Left(Failure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    final isConnected = await network_info.isConnected;
    if (isConnected == true) {
      try {
        final token =  await localDataSource.getAccessToken();

        if (token == null) {
          return Left(Failure('User not authenticated'));
        }

        final userModel = await remoteDataSource.getUserProfile(token);

        final userProfile = User(
          id: userModel.id,
          name: userModel.name,
          email: userModel.email,
        );

        return Right(userProfile);
      } catch (e) {
        return Left(Failure('An unexpected error occurred'));
      }
    } else {
      return Left(Failure('No Internet Connection'));
    }
  }

  
  
  @override
  Future<Either<Failure, void>> logout() async {
   try {
      await localDataSource.deleteAccessToken();
      return Right(null);
    } catch (e) {
      return Left(Failure('user not logout'));
    }
  }
  
 
}
