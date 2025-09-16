import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/widgets/example_widget.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/provider/counter_notifier.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(child: ExampleWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterNotifier>(
            context,
            listen: false,
          ).incrementCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
