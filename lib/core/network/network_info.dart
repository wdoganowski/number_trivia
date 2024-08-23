// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  InternetConnection connectionChecker;
  
  NetworkInfoImpl({
    required this.connectionChecker,
  });

  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
  
}
