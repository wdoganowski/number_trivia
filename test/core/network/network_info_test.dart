import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:mockito/annotations.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnection>()])

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnection mockInternetConnection;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(connectionChecker: mockInternetConnection);
  });

	group(
		'isConnected', 
		() {
			test(
				'should respond true when the InternetConnection.hasInternetAccess',
				() async {
          // arrange
          when(mockInternetConnection.hasInternetAccess)
            .thenAnswer((_) async => true);
          // act
          final result = await networkInfo.isConnected;
          // assert
          verify(mockInternetConnection.hasInternetAccess);
          expect(result, true);
				},
			);
			test(
				'should respond false when the no InternetConnection.hasInternetAccess',
				() async {
          // arrange
          when(mockInternetConnection.hasInternetAccess)
            .thenAnswer((_) async => false);
          // act
          final result = await networkInfo.isConnected;
          // assert
          verify(mockInternetConnection.hasInternetAccess);
          expect(result, false);
				},
			);
		},
	);
}