import 'package:clean_architecture/features/auth/domain/usecases/getuserprofile_usecase.dart';
import 'package:clean_architecture/features/auth/domain/usecases/loginuser_usecase.dart';
import 'package:clean_architecture/features/auth/domain/usecases/logoutuser.dart';
import 'package:clean_architecture/features/auth/domain/usecases/registeruser_usecase.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_event.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final RegisterUserUseCase registerUserUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;
  final LoginUserUseCase loginUserUseCase;
  final LogoutUserUseCase logoutuserUseCase;

  UserBloc({ required this.getUserProfileUseCase,required this.logoutuserUseCase, required  this.loginUserUseCase, required this.registerUserUseCase}) : super(InitialUserState()) {
    on<LoginUserEvent>(_onLoginUserEvent);
    on<RegisterUserEvent>(_onRegisterUserEvent);
    on<FetchUserProfileEvent>(_onFetchUserProfileEvent);
    on<LogoutUserEvent>(_onLogoutUserEvent);
  }

  Future<void> _onLoginUserEvent(LoginUserEvent event, Emitter<UserState> emit,
  ) async {
    emit(LoadingUserState());
    final result = await loginUserUseCase.loginUser(event.email, event.password);
    result.fold(
      (failure) => emit(ErrorUserState(errorMessage: failure.message)),
      (accessToken) => emit(LoggedInUserState(accessToken: accessToken)),
    );
  }

  Future<void> _onRegisterUserEvent(RegisterUserEvent event,Emitter<UserState> emit,
  ) async {
    emit(LoadingUserState());
  
    final result = await registerUserUseCase.registerUser(
     event.user
    );
    print('${result} sefina registered');
    result.fold(
      (failure) => emit(ErrorUserState(errorMessage: failure.message)),
      (user) => emit(RegisteredUserState(user:user )),);
    
  }

  Future<void> _onFetchUserProfileEvent(
    FetchUserProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(LoadingUserState());
    final result = await getUserProfileUseCase.getUserProfile();
    result.fold(
      (failure) => emit(ErrorUserState(errorMessage: failure.message)),
      (user) => emit(UserProfileLoadedState(user: user)),
    );
  }

  Future<void> _onLogoutUserEvent(
    LogoutUserEvent event,
    Emitter<UserState> emit,
  ) async {
    final result = await logoutuserUseCase.logout();
    result.fold(
      (failure) => emit(ErrorUserState(errorMessage: failure.message)),
      (_) => emit(LoggedOutUserState()),
      
    );
  }
  
}
