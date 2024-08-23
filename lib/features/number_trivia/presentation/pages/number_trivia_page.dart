import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/trivia_control_state.dart';

import '../../../../injection_container.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_widget.dart';
import '../widgets/trivia_display_widget.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: _buildBody(context));
  }

  BlocProvider<NumberTriviaBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Top half
              _topHalfPage(context),
              const SizedBox(height: 20),
              // Bottom half
              TriviaControlState(context: context)
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<NumberTriviaBloc, NumberTriviaState> _topHalfPage(
      BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
      if (state is Empty) {
        return MessageDisplayWidget(
            context: context, message: 'What number do you want?!');
      } else if (state is Error) {
        return MessageDisplayWidget(context: context, message: state.message);
      } else if (state is Loading) {
        return LoadingWidget(context: context);
      } else if (state is Loaded) {
        return TriviaDisplayWidget(
            context: context, numberTrivia: state.trivia);
      } else {
        return MessageDisplayWidget(context: context, message: 'Unknown error');
      }
    });
  }
}

