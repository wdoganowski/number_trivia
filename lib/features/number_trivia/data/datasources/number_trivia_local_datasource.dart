
import '../../domain/entities/number_trivia.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  /// Gets last trivia from the cache.
  ///
  /// Throws a [CacheException] for all error codes.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Cache number trivia model.
  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache);
}