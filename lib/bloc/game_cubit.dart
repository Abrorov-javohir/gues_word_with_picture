import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class GameCubit extends Cubit<List<String>> {
  GameCubit() : super([]) {
    _setNewQuestion();
  }

  final Map<String, List<String>> games = {
    "milk": [
      "https://cdn.britannica.com/55/174255-050-526314B6/brown-Guernsey-cow.jpg",
      "https://cdn.britannica.com/77/200377-050-4326767F/milk-splashing-glass.jpg",
      "https://cdn.britannica.com/33/166933-050-1475B953/Stick-butter.jpg",
      "https://www.indooroutdoors.co.uk/cdn/shop/products/4_5108b67f-e8b2-4c75-8d07-78719ab731ff.jpg?v=1696243244",
    ],
    "cake": [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBnfTXs9DpaPffvPTpjsS2XrGmEqiS1PebKA&s",
      "https://handletheheat.com/wp-content/uploads/2015/03/Best-Birthday-Cake-with-milk-chocolate-buttercream-SQUARE.jpg",
      "https://www.recipegirl.com/wp-content/uploads/2015/01/Kit-Kat-Cake-1-500x500.jpg",
      "https://cakebycourtney.com/wp-content/uploads/2015/08/Cookies-and-Cream-Cake-4-500x375.jpg",
    ],
    "tree": [
      "https://www.adobe.com/content/dam/cc/us/en/creativecloud/illustration-adobe-illustration/how-to-draw-trees/draw-trees_fb-img_1200x800.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8q11Gdj6ljM4WX5RUCdwiXhCFvbOm3ZgNbQ&s",
      "https://static.vecteezy.com/system/resources/thumbnails/008/132/083/small_2x/green-tree-cartoon-isolated-on-white-background-illustration-of-green-tree-cartoon-free-vector.jpg",
      "https://static.vecteezy.com/system/resources/previews/022/432/338/non_2x/green-tree-with-leaves-outline-illustration-plant-in-garden-vector.jpg",
    ],
    "book": [
      "https://media.istockphoto.com/id/173015527/photo/a-single-red-book-on-a-white-surface.jpg?s=612x612&w=0&k=20&c=AeKmdZvg2_bRY2Yct7odWhZXav8CgDtLMc_5_pjSItY=",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFhtziUi-Hm8BPQx0vCwFhwwXRhktkfdpVDA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjtO-VZ__nzfsmZ_EvGHLGynXQaJvkb8ZJ3g&s",
      "https://m.media-amazon.com/images/I/612BYerla-L._AC_UF1000,1000_QL80_.jpg",
    ],
  };

  final List<Map<String, String>> _questions = [
    {"answer": "milk"},
    {"answer": "cake"},
    {"answer": "tree"},
    {"answer": "book"},
  ];

  late String _currentAnswer;
  late List<String> _currentImages;
  late List<String> _shuffledLetters;

  String get currentAnswer => _currentAnswer;
  List<String> get currentImages => _currentImages;
  List<String> get shuffledLetters => _shuffledLetters;

  void _setNewQuestion() {
    if (_questions.isNotEmpty) {
      final question = _questions.removeAt(0);
      _currentAnswer = question["answer"]!;
      _currentImages = games[_currentAnswer]!;
      _shuffledLetters = _shuffleLetters(_currentAnswer);
      emit([]);
    } else {
      // No more questions left
      emit([]); // You can handle the end of the game here
    }
  }

  List<String> _shuffleLetters(String answer) {
    final random = Random();
    final letters = answer.split('');
    final extraLetters = List.generate(4, (_) => String.fromCharCode(random.nextInt(26) + 97)); // Adding extra random letters
    letters.addAll(extraLetters);
    letters.shuffle();
    return letters;
  }

  void startGame(String answer) {
    _currentAnswer = answer;
    _currentImages = games[_currentAnswer]!;
    _shuffledLetters = _shuffleLetters(_currentAnswer);
    emit([]);
  }

  void addLetter(String letter) {
    if (state.length < _currentAnswer.length) {
      emit(List.from(state)..add(letter));
    }
  }

  void removeLetter(String letter) {
    emit(List.from(state)..remove(letter));
  }

  bool checkAnswer() {
    return state.join().toLowerCase() == _currentAnswer;
  }

  void nextQuestion() {
    _setNewQuestion();
  }

  void reset() {
    emit([]);
    _setNewQuestion();
  }
}
