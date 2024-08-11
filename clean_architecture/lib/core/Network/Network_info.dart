import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class  Network_info
{
 Future<bool> get isConnected;
}
class NetworkInfoImpl implements Network_info

{

  final DataConnectionChecker connectivity;
  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected => connectivity.hasConnection;
  
}