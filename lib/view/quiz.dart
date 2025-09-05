import 'package:flutter/material.dart';
import 'dart:math';
import 'result.dart';

class QuizPage extends StatefulWidget {
  final Map<String, String> kanaMap;
  final int questionCount;
  final String difficulty;
  final String inputMode;

  const QuizPage({
    super.key,
    required this.kanaMap,
    required this.questionCount,
    required this.difficulty,
    required this.inputMode,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final random = Random();
  final controller = TextEditingController();
  late Map<String, String> question;
  bool kanaToKorean = true;
  int score = 0;
  int current = 1;
  String feedback = "";

  @override
  void initState() {
    super.initState();
    question = generateQuestion();
  }

  Map<String, String> generateQuestion() {
    final keys = widget.kanaMap.keys.toList();
    final kana = keys[random.nextInt(keys.length)];

    if (widget.difficulty == "easy") {
      kanaToKorean = true;
    } else if (widget.difficulty == "normal") {
      kanaToKorean = false;
    } else {
      kanaToKorean = random.nextBool();
    }

    return {kana: widget.kanaMap[kana]!};
  }

  void checkAnswer() {
    final kana = question.keys.first;
    final korean = question.values.first;
    final userAnswer = controller.text.trim();

    bool correct;

    if (kanaToKorean) {
      correct = (userAnswer == korean);
    } else {
      if (widget.inputMode == "hiragana") {
        correct = (userAnswer == kana && _isHiragana(kana));
      } else if (widget.inputMode == "katakana") {
        correct = (userAnswer == kana && _isKatakana(kana));
      } else {
        correct = (userAnswer == kana);
      }
    }

    if (correct) {
      score++;
      feedback = "✅ 정답!";
    } else {
      feedback = kanaToKorean ? "❌ 오답! 정답: $korean" : "❌ 오답! 정답: $kana";
    }

    if (current >= widget.questionCount) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(score: score, total: widget.questionCount),
        ),
      );
      return;
    }

    controller.clear();
    setState(() {
      current++;
      question = generateQuestion();
    });
  }

  bool _isHiragana(String s) {
    final code = s.codeUnitAt(0);
    return code >= 0x3040 && code <= 0x309F;
  }

  bool _isKatakana(String s) {
    final code = s.codeUnitAt(0);
    return code >= 0x30A0 && code <= 0x30FF;
  }

  @override
  Widget build(BuildContext context) {
    final kana = question.keys.first;
    final korean = question.values.first;

    return Scaffold(
      appBar: AppBar(title: Text("퀴즈 $current/${widget.questionCount}")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(kanaToKorean ? kana : korean, style: const TextStyle(fontSize: 64)),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: kanaToKorean ? "한국어로 입력" : "가나로 입력",
              ),
              onSubmitted: (_) => checkAnswer(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: checkAnswer, child: const Text("확인")),
            const SizedBox(height: 20),
            Text(feedback, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text("점수: $score"),
          ],
        ),
      ),
    );
  }
}
