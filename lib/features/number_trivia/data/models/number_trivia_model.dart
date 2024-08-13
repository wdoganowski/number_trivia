import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required super.number,
    required super.text,
  });

  factory NumberTriviaModel.fromJson(Map<String, dynamic> jsonMap) {
    return NumberTriviaModel(text: jsonMap['text'], number: (jsonMap['number'] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text
    };
  }
}
