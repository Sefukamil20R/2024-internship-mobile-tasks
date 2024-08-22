import 'package:clean_architecture/core/Network/Network_info.dart';
import 'package:clean_architecture/features/auth/data/data_source/localdatasource.dart';
import 'package:clean_architecture/features/auth/data/data_source/remotedatasource.dart';
import 'package:clean_architecture/features/auth/data/repositories/user_repositories_impl.dart';
import 'package:clean_architecture/features/auth/domain/repository/user_repositories.dart';
import 'package:clean_architecture/features/auth/domain/usecases/getuserprofile_usecase.dart';
import 'package:clean_architecture/features/auth/domain/usecases/loginuser_usecase.dart';
import 'package:clean_architecture/features/auth/domain/usecases/logoutuser.dart';
import 'package:clean_architecture/features/auth/domain/usecases/registeruser_usecase.dart';
import 'package:clean_architecture/features/auth/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture/features/product/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/features/product/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/features/product/data/repositories/product_repository_imp.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';
import 'package:clean_architecture/features/product/domain/usecases/add_product.dart';
import 'package:clean_architecture/features/product/domain/usecases/delete_product.dart';
import 'package:clean_architecture/features/product/domain/usecases/get_allproduct.dart';
import 'package:clean_architecture/features/product/domain/usecases/get_specproduct.dart';
import 'package:clean_architecture/features/product/domain/usecases/update_product.dart';
import 'package:clean_architecture/features/product/presentation/bloc/Product/product_bloc.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



final locator = GetIt.instance;
Future <void> setupLocator() async {
  

  //bloc_product
  locator.registerFactory(() => ProductBloc(
        getAllproductusecase: locator(),
        getSpecproductsusecase: locator(),
        deleteProductusecase: locator(),
        updateProductusecase: locator(),
        addProductusecase: locator(),
      ));
  //users_bloc
  locator.registerFactory( () => UserBloc(
    getUserProfileUseCase: locator(),
    loginUserUseCase: locator(),
    registerUserUseCase: locator(),
    logoutuserUseCase: locator(),
  ));






  
    
  //use cases
  locator.registerLazySingleton(()=> GetAllproductusecase(locator()));
  locator.registerLazySingleton(()=> GetSpecproductsusecase(locator()));
  locator.registerLazySingleton(()=> UpdateProductusecase(locator()));
  locator.registerLazySingleton(()=> AddProductUseCase(locator()));
  locator.registerLazySingleton(()=> DeleteProductusecase(locator()));
  //user_usecase
  locator.registerLazySingleton(()=> GetUserProfileUseCase(locator()));
  locator.registerLazySingleton(()=> LoginUserUseCase(locator()));
  locator.registerLazySingleton(()=> RegisterUserUseCase(locator()));
  locator.registerLazySingleton<LogoutUserUseCase>(()=> LogoutUserUseCase(locator()));
  // Repository
  locator.registerLazySingleton<ProductRepositories>(() => ProductRepositoryImpl(
  network_info: locator(),
  remoteDataSource: locator(),
  localDataSource: locator(),
  ));
  //user_repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
    network_info: locator(),
    remoteDataSource: locator(),
    localDataSource: locator(),
  ));
  // Data Source
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
  client: locator(), userLocalDataSource: locator()));
  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(
    sharedPreferences: locator(),
  ));
  //user_datasource
  locator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(
    client: locator(),
  ));
  // local_datasource
  locator.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(
    sharedPreferences: locator(),
  ));
 
  
  // network_info
  //core
   locator.registerLazySingleton<Network_info>(
      () => NetworkInfoImpl(locator()));
  // External
  final sharedPreference = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreference);
  locator.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  locator.registerLazySingleton<http.Client>(() => http.Client());
 
}
