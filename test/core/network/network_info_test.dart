import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:mockito/annotations.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DataConnectionChecker>()])

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(connectionChecker: mockDataConnectionChecker);
  });

	group(
		'isConnected', 
		() {
			test(
				'should respond true when the DataConnectionChecker.hasConnection',
				() async {
          // arrange
          when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
          // act
          final result = await networkInfo.isConnected;
          // assert
          verify(mockDataConnectionChecker.hasConnection);
          expect(result, true);
				},
			);
			test(
				'should respond false when the no DataConnectionChecker.hasConnection',
				() async {
          // arrange
          when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) async => false);
          // act
          final result = await networkInfo.isConnected;
          // assert
          verify(mockDataConnectionChecker.hasConnection);
          expect(result, false);
				},
			);
		},
	);
}