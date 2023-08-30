import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(CronometroApp());
}

class CronometroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronômetro App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: CronometroScreen(),
    );
  }
}

class CronometroScreen extends StatefulWidget {
  @override
  _CronometroScreenState createState() => _CronometroScreenState();
}

class _CronometroScreenState extends State<CronometroScreen> {
  bool isRunning = false;
  int seconds = 0;
  List<String> marks = [];

  void startTimer() {
    setState(() {
      isRunning = true;
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isRunning) {
        timer.cancel();
      } else {
        setState(() {
          seconds++;
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      isRunning = false;
    });
  }

  void markTime() {
    setState(() {
      marks.add(_formatTime(seconds));
    });
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      seconds = 0;
      marks.clear();
    });
  }

  String _formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronômetro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(seconds),
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!isRunning)
                  ElevatedButton(
                    onPressed: startTimer,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child:
                        Text('INICIAR', style: TextStyle(color: Colors.white)),
                  ),
                if (isRunning)
                  ElevatedButton(
                    onPressed: stopTimer,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    child: Text('PARAR', style: TextStyle(color: Colors.white)),
                  ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: markTime,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                  ),
                  child: Text('MARCAR', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetTimer,
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
              ),
              child: Text('LIMPAR', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Column(
              children: marks
                  .map((mark) => Text(mark, style: TextStyle(fontSize: 20)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
