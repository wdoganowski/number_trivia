import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart'; 
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import './number_trivia_local_datasource_test.mocks.dart';

void main() {
  late NumberTriviaLocalDatasourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDatasourceImpl(sharedPreferences: mockSharedPreferences);
  });

	group(
		'getLastNumberTrivia', 
		() {
      final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
			test(
				'should return NumberTrivia from SharedPreferences when there is one in the cache',
				() async {
          // arrange
          when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
          // act
          final result = await dataSource.getLastNumberTrivia();
          // assert
          verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
          expect(result, equals(tNumberTriviaModel));
				},
			);
      test(
        'should throw a CacheException when there is nothing in the cache',
        () async {
          // arrange
          when(mockSharedPreferences.getString(any))
              .thenReturn(null);
          // act
          final call = dataSource.getLastNumberTrivia;
          // assert
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
		},
	);

  group(
    'cacheNumberTrivia', 
    () {
      const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Trivia');
      test(
        'should call SharedPreferences to cache the data',
        () async {
          // act
          dataSource.cacheNumberTrivia(tNumberTriviaModel);
          // assert
          final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
          verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString));
        },
      );
    }
  );
}