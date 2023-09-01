import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_timer/timer_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final TimerStore _timerStore = TimerStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cronômetro'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(
                builder: (_) => _timerStore.isRunning
                    ? Text(
                        _timerStore._formatTime(_timerStore.seconds),
                        style: TextStyle(fontSize: 40),
                      )
                    : ElevatedButton(
                        onPressed: _timerStore.startTimer,
                        child: Text('INICIAR'),
                      ),
              ),
              SizedBox(height: 20),
              Observer(
                builder: (_) {
                  if (_timerStore.isRunning) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: _timerStore.stopTimer,
                          child: Text('PARAR'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _timerStore.mark,
                          child: Text('MARCAR'),
                        ),
                      ],
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: _timerStore.resetTimer,
                      child: Text('LIMPAR'),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Observer(
                builder: (_) => Column(
                  children: _timerStore.marks
                      .map((mark) => Text(mark, style: TextStyle(fontSize: 20)))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
