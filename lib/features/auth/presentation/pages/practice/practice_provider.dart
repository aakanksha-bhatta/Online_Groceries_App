import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// this provider only read/ show the static value it does not update or change.
final mssgProvider = Provider<String>((ref) {
  return 'Hello Provider';
});

//state provider update or change it mainly use for small ui state to change
//it only hold  single value
final counterProvider = StateProvider<int>((ref) => 0);

//working with change notifier to look difference, can make 1 class
// here we can hold multiple value
class CounterNotifier extends ChangeNotifier {
  int _count1 = 0;
  int _count2 = 0;

  int get count1 => _count1;
  int get count2 => _count2;

  void incrementCounter1() {
    _count1++;
    notifyListeners();
  }

  void incrementCounter2() {
    _count2++;
    notifyListeners();
  }
}

final counterChangeNotifierProvider = ChangeNotifierProvider<CounterNotifier>(
  (ref) => CounterNotifier(),
);

//State notifier

// State class (optional for simple cases, but good practice)
class CounterState {
  final int count;
  CounterState(this.count);
}

// StateNotifier class
class CounterNotifier1 extends StateNotifier<int> {
  CounterNotifier1() : super(0);

  void increment() {
    state = state + 1;
  }

  void decrement() {
    state = state - 1;
  }
}

// Provider for the notifier
final notifiercounterProvider = StateNotifierProvider<CounterNotifier1, int>(
  (ref) => CounterNotifier1(),
);
