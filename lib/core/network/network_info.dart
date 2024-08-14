// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  DataConnectionChecker connectionChecker;
  
  NetworkInfoImpl({
    required this.connectionChecker,
  });

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
  
}
