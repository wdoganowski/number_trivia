
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControlState extends StatefulWidget {
  const TriviaControlState({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<TriviaControlState> createState() => _TriviaControlStateState();
}

class _TriviaControlStateState extends State<TriviaControlState> {
  late String inputString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text field
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) => inputString = value,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: const Text('Search'),
                onPressed: () => _dispatchConcrete(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade600),
                onPressed: () => _dispatchRandom(),
                child: const Text('Get random trivia'),
              ),
            )
          ],
        )
      ],
    );
  }

  void _dispatchConcrete() {
    BlocProvider.of<NumberTriviaBloc>(context)
      .add(GetTriviaForConcreteNumber(numberString: inputString));
  }

  void _dispatchRandom() {
    BlocProvider.of<NumberTriviaBloc>(context)
      .add(GetTriviaForRandomNumber());
  }
}
