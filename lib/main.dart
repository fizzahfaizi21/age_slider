import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(
    // Provide the model to all widgets within the app
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

const double windowWidth = 360;
const double windowHeight = 640;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Counter');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

/// Counter model with methods to update its value
class Counter with ChangeNotifier {
  int value = 0;

  // Method to increment counter
  void increment() {
    value += 1;
    notifyListeners();
  }

  // Method to decrement counter
  void decrement() {
    value -= 1;
    notifyListeners();
  }

  // Method to set counter to a specific value
  void setValue(int newValue) {
    value = newValue;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter with Slider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Counter with Slider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Adjust the slider to change the counter value:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            // Consumer widget that rebuilds when Counter changes
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 50),
            // Slider to control the counter value
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<Counter>(
                builder: (context, counter, child) {
                  return Column(
                    children: [
                      Slider(
                        min: -10,
                        max: 10,
                        divisions: 20,
                        value: counter.value.toDouble(),
                        label: counter.value.toString(),
                        onChanged: (double value) {
                          counter.setValue(value.round());
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('-10'),
                          const Text('0'),
                          const Text('10'),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            // Manual increment/decrement buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<Counter>().decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<Counter>().increment();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
