
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  /// Gets last trivia from the cache.
  ///
  /// Throws a [CacheException] for all error codes.
  Future<NumberTriviaModel> getConcreteLastTrivia(int number);

  /// Cache number trivia model.
  Future<void> cacheRandomNumberTrivia(NumberTriviaModel triviaToCache);
}