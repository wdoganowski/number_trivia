import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';

import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import './number_trivia_remote_datasource_test.mocks.dart';

void main() {
  late NumberTriviaRemoteDatasourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDatasourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('trivia_integer.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group(
    'getConcreteNumberTrivia',
    () {
      final tNumber = 1;
      final tNumberTriviaModel = NumberTriviaModel.fromJson(
          json.decode(fixture('trivia_integer.json')));

      test(
        '''should perform a GET request on a URL with the number being the endpoint 
        and with application/json header''',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          dataSource.getConcreteNumberTrivia(tNumber);
          // assert
          verify(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'}));
        },
      );

      test(
        'should return a NumberTrivia when the response code is 200',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          final result = await dataSource.getConcreteNumberTrivia(tNumber);
          // assert
          expect(result, equals(tNumberTriviaModel));
        },
      );

      test(
        'should throw a ServerException when the response code is 4xx',
        () async {
          // arrange
          setUpMockHttpClientFailure404();
          // act
          final call = dataSource.getConcreteNumberTrivia;
          // assert
          expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
        },
      );
    },
  );

group(
    'getRandomNumberTrivia',
    () {
      final tNumberTriviaModel = NumberTriviaModel.fromJson(
          json.decode(fixture('trivia_integer.json')));

      test(
        '''should perform a GET request on a URL with the number being the endpoint 
        and with application/json header''',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          dataSource.getRandomNumberTrivia();
          // assert
          verify(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
              headers: {'Content-Type': 'application/json'}));
        },
      );

      test(
        'should return a NumberTrivia when the response code is 200',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          final result = await dataSource.getRandomNumberTrivia();
          // assert
          expect(result, equals(tNumberTriviaModel));
        },
      );

      test(
        'should throw a ServerException when the response code is 4xx',
        () async {
          // arrange
          setUpMockHttpClientFailure404();
          // act
          final call = dataSource.getRandomNumberTrivia;
          // assert
          expect(() => call(), throwsA(TypeMatcher<ServerException>()));
        },
      );
    },
  );
}

