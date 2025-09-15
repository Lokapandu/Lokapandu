import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/provider/counter_provider.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Consumer<CounterProvider>(
              builder: (context, counterProvider, child) {
                return Text(
                  '${counterProvider.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterProvider>(context, listen: false).incrementCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
