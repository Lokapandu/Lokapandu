import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/provider/counter_notifier.dart';
import 'package:provider/provider.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('You have pushed the button this many times:'),
        Consumer<CounterNotifier>(
          builder: (context, counterProvider, child) {
            return Text(
              '${counterProvider.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ],
    );
  }
}
