import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia,NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(params) async {
    return await repository.getRandomNumberTrivia();
  }
}