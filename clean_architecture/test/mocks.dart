import 'package:clean_architecture/core/Network/Network_info.dart';
import 'package:clean_architecture/features/product/data/data_sources/remote_data_source.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:clean_architecture/core/network/network_info.dart';


@GenerateMocks([ProductRepositories,DataConnectionChecker , Network_info, http.Client, RemoteDataSource,SharedPreferences])
//  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
// @GenerateMocks([ProductRepositories, RemoteDataSource, Network_info])

void main() {}

