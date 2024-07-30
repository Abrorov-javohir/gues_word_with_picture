import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gues_word_with_picture/bloc/game_cubit.dart';
import 'package:gues_word_with_picture/screens/game_screen.dart';

void main() {
  group(
    "GameScreen widget tests",
    () {
      testWidgets(
        "Checks presence of ElevatedButtons",
        (widgetTester) async {
          // Create a GameCubit instance
          final gameCubit = GameCubit();

          // Build our app and trigger a frame
          await widgetTester.pumpWidget(
            MaterialApp(
              home: BlocProvider(
                create: (_) => gameCubit,
                child: const GameScreen(),
              ),
            ),
          );

          // Verify the presence of ElevatedButtons
          expect(find.byType(ElevatedButton), findsNWidgets(3));
        },
      );

      testWidgets(
        "Check if images are loaded",
        (widgetTester) async {
          // Create a GameCubit instance
          final gameCubit = GameCubit();

          // Build our app and trigger a frame
          await widgetTester.pumpWidget(
            MaterialApp(
              home: BlocProvider(
                create: (_) => gameCubit,
                child: const GameScreen(),
              ),
            ),
          );

          // Verify if images are loaded
          expect(find.byType(Image), findsWidgets);
        },
      );

      testWidgets(
        "Check if next question works",
        (widgetTester) async {
          // Create a GameCubit instance
          final gameCubit = GameCubit();

          // Build our app and trigger a frame
          await widgetTester.pumpWidget(
            MaterialApp(
              home: BlocProvider(
                create: (_) => gameCubit,
                child: const GameScreen(),
              ),
            ),
          );

          // Tap the next question button
          await widgetTester
              .tap(find.byKey(const ValueKey("NextQuestionButton")));
          await widgetTester.pump();

          // Verify if the next question is loaded
          expect(find.text(gameCubit.currentAnswer), findsNothing);
        },
      );

      testWidgets(
        "Check if reset works",
        (widgetTester) async {
          // Create a GameCubit instance
          final gameCubit = GameCubit();

          // Build our app and trigger a frame
          await widgetTester.pumpWidget(
            MaterialApp(
              home: BlocProvider(
                create: (_) => gameCubit,
                child: const GameScreen(),
              ),
            ),
          );

          // Tap the reset button
          await widgetTester.tap(find.byKey(const ValueKey("ResetButton")));
          await widgetTester.pump();

          // Verify if the game is reset
          expect(gameCubit.state, isEmpty);
        },
      );

      testWidgets(
        "Check if answer checking works",
        (widgetTester) async {
          // Create a GameCubit instance
          final gameCubit = GameCubit();

          // Build our app and trigger a frame
          await widgetTester.pumpWidget(
            MaterialApp(
              home: BlocProvider(
                create: (_) => gameCubit,
                child: const GameScreen(),
              ),
            ),
          );

          // Add letters to form the correct answer
          for (var letter in gameCubit.currentAnswer.split('')) {
            gameCubit.addLetter(letter);
          }

          // Tap the check answer button
          await widgetTester
              .tap(find.byKey(const ValueKey("CheckAnswerButton")));
          await widgetTester.pump();

          // Verify if the answer is correct
          expect(find.text('Correct!'), findsOneWidget);
        },
      );
    },
  );
}
