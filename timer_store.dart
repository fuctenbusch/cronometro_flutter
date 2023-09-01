import 'package:mobx/mobx.dart';

part 'timer_store.g.dart';

class TimerStore = _TimerStore with _$TimerStore;

abstract class _TimerStore with Store {
  @observable
  bool isRunning = false;

  @observable
  int seconds = 0;

  @observable
  ObservableList<String> marks = ObservableList<String>();

  Timer? _timer;

  @action
  void startTimer() {
    isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds++;
    });
  }

  @action
  void stopTimer() {
    isRunning = false;
    _timer?.cancel();
  }

  @action
  void mark() {
    marks.add(_formatTime(seconds));
  }

  @action
  void resetTimer() {
    seconds = 0;
    marks.clear();
    _timer?.cancel();
    isRunning = false;
  }

  String _formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
