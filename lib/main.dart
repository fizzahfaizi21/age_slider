import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AgeCounter(),
      child: const MyApp(),
    ),
  );
}

class AgeCounter with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }

  void decrement() {
    if (value > 0) {
      value -= 1;
      notifyListeners();
    }
  }

  void setValue(int newValue) {
    if (newValue >= 0) {
      value = newValue;
      notifyListeners();
    }
  }

  String getMilestoneMessage() {
    if (value >= 0 && value <= 12) {
      return "Childhood: Enjoy your early years!";
    } else if (value >= 13 && value <= 19) {
      return "Teenage Years: Discovering who you are";
    } else if (value >= 20 && value <= 29) {
      return "Twenties: Building your foundation";
    } else if (value >= 30 && value <= 39) {
      return "Thirties: Establishing your path";
    } else if (value >= 40 && value <= 49) {
      return "Forties: Mid-life adventures";
    } else if (value >= 50 && value <= 59) {
      return "Fifties: Wisdom and purpose";
    } else if (value >= 60 && value <= 69) {
      return "Sixties: Retirement planning";
    } else if (value >= 70 && value <= 79) {
      return "Seventies: Golden years";
    } else if (value >= 80 && value <= 89) {
      return "Eighties: Legacy building";
    } else {
      return "Nineties+: Legendary status!";
    }
  }

  Color getMilestoneColor() {
    if (value >= 0 && value <= 12) {
      return Colors.lightBlue[100]!; // Childhood
    } else if (value >= 13 && value <= 19) {
      return Colors.orange[100]!; // Teenage
    } else if (value >= 20 && value <= 29) {
      return Colors.green[100]!; // Twenties
    } else if (value >= 30 && value <= 39) {
      return Colors.amber[100]!; // Thirties
    } else if (value >= 40 && value <= 49) {
      return Colors.purple[100]!; // Forties
    } else if (value >= 50 && value <= 59) {
      return Colors.teal[100]!; // Fifties
    } else if (value >= 60 && value <= 69) {
      return Colors.indigo[100]!; // Sixties
    } else if (value >= 70 && value <= 79) {
      return Colors.brown[100]!; // Seventies
    } else if (value >= 80 && value <= 89) {
      return Colors.deepOrange[100]!; // Eighties
    } else {
      return Colors.red[100]!; // Nineties+
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AgeCounter>(
      builder: (context, ageCounter, child) {
        return MaterialApp(
          title: 'Age Milestone Counter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: MyHomePage(backgroundColor: ageCounter.getMilestoneColor()),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Color backgroundColor;

  const MyHomePage({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Consumer<AgeCounter>(
      builder: (context, ageCounter, child) {
        return Scaffold(
          backgroundColor: ageCounter.getMilestoneColor(),
          appBar: AppBar(
            title: const Text('Age Milestone Counter'),
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your Current Age:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${ageCounter.value}',
                    style: const TextStyle(
                        fontSize: 72, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      ageCounter.getMilestoneMessage(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: ageCounter.value > 0
                            ? () => ageCounter.decrement()
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () => ageCounter.increment(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Drag to set your age:',
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.7)),
                  ),
                  Slider(
                    min: 0,
                    max: 100,
                    divisions: 100,
                    value: ageCounter.value.toDouble(),
                    label: ageCounter.value.toString(),
                    onChanged: (double value) {
                      ageCounter.setValue(value.toInt());
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('0'),
                        const Text('50'),
                        const Text('100'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
