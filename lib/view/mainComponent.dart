import 'package:flutter/material.dart';
import 'setting.dart';
// import 'data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("일본어 퀴즈")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("히라가나 퀴즈"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingPage(
                      kanaMap: {},
                      title: "히라가나",
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("가타카나 퀴즈"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingPage(
                      kanaMap: {},
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
