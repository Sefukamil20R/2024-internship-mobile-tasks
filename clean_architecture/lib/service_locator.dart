import 'package:clean_architecture/core/Network/Network_info.dart';
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
  

  //bloc
  locator.registerFactory(() => ProductBloc(
        getAllproductusecase: locator(),
        getSpecproductsusecase: locator(),
        deleteProductusecase: locator(),
        updateProductusecase: locator(),
        addProductusecase: locator(),
      ));
  //use cases
  locator.registerLazySingleton(()=> GetAllproductusecase(locator()));
  locator.registerLazySingleton(()=> GetSpecproductsusecase(locator()));
  locator.registerLazySingleton(()=> UpdateProductusecase(locator()));
  locator.registerLazySingleton(()=> AddProductUseCase(locator()));
  locator.registerLazySingleton(()=> DeleteProductusecase(locator()));
  // Repository
  locator.registerLazySingleton<ProductRepositories>(() => ProductRepositoryImpl(
  network_info: locator(),
  remoteDataSource: locator(),
  localDataSource: locator(),
  ));
  // Data Source
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
  client: locator()));
  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(
    sharedPreferences: locator(),
  ));
  //core
   locator.registerLazySingleton<Network_info>(
      () => NetworkInfoImpl(locator()));
  // External
  final sharedPreference = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreference);
  locator.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  locator.registerLazySingleton(() => http.Client());
 
}
