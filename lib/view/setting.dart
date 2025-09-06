import 'package:flutter/material.dart';
import 'quiz.dart';

class SettingPage extends StatefulWidget {
  final Map<String, String> kanaMap;
  final String title;

  const SettingPage({super.key, required this.kanaMap, required this.title});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int questionCount = 10;
  String difficulty = "easy"; // easy, normal, hard
  String inputMode = "hiragana"; // hiragana, katakana, both

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.title} 설정")),
      body: Center(
        // padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("문제 개수", style: TextStyle(fontSize: 18)),
            DropdownButton<int>(
              value: questionCount,
              items: [10, 20, 30]
                  .map((n) => DropdownMenuItem(value: n, child: Text("$n")))
                  .toList(),
              onChanged: (v) => setState(() => questionCount = v!),
            ),
            const SizedBox(height: 20),
            const Text("난이도", style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: difficulty,
              items: [
                DropdownMenuItem(value: "easy", child: Text("쉬움 (가나→한국어)")),
                DropdownMenuItem(value: "normal", child: Text("보통 (한국어→가나)")),
                DropdownMenuItem(value: "hard", child: Text("어려움 (랜덤)")),
              ],
              onChanged: (v) => setState(() => difficulty = v!),
            ),
            const SizedBox(height: 20),
            const Text("정답 입력 방식", style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: inputMode,
              items: [
                DropdownMenuItem(value: "hiragana", child: Text("히라가나만")),
                DropdownMenuItem(value: "katakana", child: Text("가타카나만")),
                DropdownMenuItem(value: "both", child: Text("둘 다 허용")),
              ],
              onChanged: (v) => setState(() => inputMode = v!),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text("퀴즈 시작"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(
                      kanaMap: widget.kanaMap,
                      questionCount: questionCount,
                      difficulty: difficulty,
                      inputMode: inputMode,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
