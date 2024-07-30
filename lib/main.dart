import 'package:flutter/material.dart';
import 'package:gues_word_with_picture/bloc/game_cubit.dart';
import 'package:gues_word_with_picture/screens/game_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GameCubit>(
          create: (_) => GameCubit(),
        ),
      ],
      child: MaterialApp(
        home: GameScreen(),
      ),
    );
  }
}
