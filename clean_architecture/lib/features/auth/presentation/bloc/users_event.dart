import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends UserEvent {
  final String email;
  final String password;

  const LoginUserEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
class Loadinguser extends UserEvent{}
class RegisterUserEvent extends UserEvent {
 final User user;

  const RegisterUserEvent({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class FetchUserProfileEvent extends UserEvent {
  

  const FetchUserProfileEvent();

  @override
  List<Object?> get props => [];
}

class LogoutUserEvent extends UserEvent {}

