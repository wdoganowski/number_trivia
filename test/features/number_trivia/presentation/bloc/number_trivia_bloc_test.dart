import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

@GenerateNiceMocks([
  MockSpec<GetConcreteNumberTrivia>(),
  MockSpec<GetRandomNumberTrivia>(),
  MockSpec<InputConverter>()
])
import 'number_trivia_bloc_test.mocks.dart';

void main() {
  late NumberTriviaBloc block;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    block = NumberTriviaBloc(Empty(),
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  void setUpMockInputConverterSuccess(int tNumberParsed) {
    when(mockInputConverter.stringToUnsignedInteger(any))
        .thenReturn(Right(tNumberParsed));
  }

  void setUpMockInputConverterFailure() {
    when(mockInputConverter.stringToUnsignedInteger(any))
        .thenReturn(Left(InvalidInputFailure()));
  }

  test(
    'initialState should be Empty',
    () async {
      expect(block.state, equals(Empty()));
    },
  );

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(number: 1, text: 'Test trivia');

    test(
      'should call the input converter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        setUpMockInputConverterSuccess(tNumberParsed);
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // act
        block.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        setUpMockInputConverterFailure();
        // assert later
        var expectedStates = [
          // Empty(),
          const Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(block.stream, emitsInOrder(expectedStates));
        // act
        block.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess(tNumberParsed);
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // act
        block.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        // assert later
        verify(
            mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)));
      },
    );

    test(
      'should emit [Loading, Loaded] when the input is valid',
      () async {
        // arrange
        setUpMockInputConverterSuccess(tNumberParsed);
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // assert later
        var expectedStates = [
          // Empty(),
          const Loading(),
          const Loaded(trivia: tNumberTrivia),
        ];
        expectLater(block.stream, emitsInOrder(expectedStates));
        // act
        block.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] when the input is valid',
      () async {
        // arrange
        setUpMockInputConverterSuccess(tNumberParsed);
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        var expectedStates = [
          // Empty(),
          const Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(block.stream, emitsInOrder(expectedStates));
        // act
        block.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] when the input is valid with proper message for error when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess(tNumberParsed);
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        var expectedStates = [
          // Empty(),
          const Loading(),
          const Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(block.stream, emitsInOrder(expectedStates));
        // act
        block.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
      },
    );
  });

  group('GetTriviaForRandomNumber', () {
    const tNumberTrivia = NumberTrivia(number: 1, text: 'Test trivia');

    test(
      'should get data from the random use case',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // act
        block.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert later
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when the input is valid',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // assert later
        var expectedStates = [
          // Empty(),
          const Loading(),
          const Loaded(trivia: tNumberTrivia),
        ];
        expectLater(block.stream, emitsInOrder(expectedStates));
        // act
        block.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] when the input is valid',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        var expectedStates = [
          // Empty(),
          const Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(block.stream, emitsInOrder(expectedStates));
        // act
        block.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] when the input is valid with proper message for error when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        var expectedStates = [
          // Empty(),
          const Loading(),
          const Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(block.stream, emitsInOrder(expectedStates));
        // act
        block.add(GetTriviaForRandomNumber());
      },
    );
  });
}
