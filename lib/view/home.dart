import 'package:flutter/material.dart';
import 'setting.dart';
import '../data/const.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("히 & 카")
        , centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text(
                "히라가나 퀴즈"
                , style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingPage(
                      kanaMap: hiraganaMap,
                      title: "히라가나",
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                 "가타카나 퀴즈"
                , style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingPage(
                      kanaMap: katakanaMap,
                      title: "가타카나",
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
