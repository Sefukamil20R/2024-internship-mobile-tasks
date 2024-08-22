import 'package:clean_architecture/features/auth/data/models/usermodel.dart';
import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class LoggedInUserState extends UserState {
  final String accessToken;

  const LoggedInUserState({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}

class RegisteredUserState extends UserState {
  final User user;

  const RegisteredUserState({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserProfileLoadedState extends UserState {
  final User user;

  const UserProfileLoadedState({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoggedOutUserState extends UserState {}

class ErrorUserState extends UserState {
  final String errorMessage;

  const ErrorUserState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
class SearchProductState extends UserState {
  final List<UserModel> products;
  
  const SearchProductState({required this.products});
  
  @override
  List<Object?> get props => [products];
}
