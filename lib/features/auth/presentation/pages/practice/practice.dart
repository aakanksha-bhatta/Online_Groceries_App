import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_groceries_app/features/auth/presentation/pages/practice/practice_provider.dart';

class Practice extends ConsumerStatefulWidget {
  const Practice({super.key});

  @override
  ConsumerState<Practice> createState() => _PracticeState();
}

class _PracticeState extends ConsumerState<Practice> {
  @override
  Widget build(BuildContext context) {
    //provider
    final message = ref.watch(mssgProvider);
    //state provider
    final stateProviderCount = ref.watch(counterProvider);
    //change provider
    final counterNotifier = ref.watch(counterChangeNotifierProvider);
    //state notifier
    final stateNotifierCount = ref.watch(notifiercounterProvider);

    return Scaffold(
      appBar: AppBar(title: Text(message)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: ${counterNotifier.count1}',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(counterChangeNotifierProvider).incrementCounter1();
              },
              child: const Text("Increment"),
            ),
            Text(
              'Counter: ${counterNotifier.count2}',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(counterChangeNotifierProvider).incrementCounter2();
              },
              child: const Text("Increment"),
            ),
            Text('Count: $counterNotifier', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () =>
                  ref.read(notifiercounterProvider.notifier).increment(),
              child: Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () =>
                  ref.read(notifiercounterProvider.notifier).decrement(),
              child: Text('Decrement'),
            ),
          ],
        ),
      ),
    );
  }
}
