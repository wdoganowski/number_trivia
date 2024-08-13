import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRemoteDatasource>(),
  MockSpec<NumberTriviaLocalDatasource>(),
  MockSpec<NetworkInfo>()
])
import './number_trivia_repository_impl_test.mocks.dart';

void main() {
  NumberTriviaRepositoryImpl repository;
  MockNumberTriviaRemoteDatasource mockRemoteDatasource;
  MockNumberTriviaLocalDatasource mockLocalDatasource;
  MockNetworkInfo mockNetworkInfo;

  setUp() {
    mockRemoteDatasource = MockNumberTriviaRemoteDatasource();
    mockLocalDatasource = MockNumberTriviaLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo
    );
  };
}
