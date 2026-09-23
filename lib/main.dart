// Stack: Flutter 3.47 (web) | File: lib/main.dart
// BUILD_STAMP is compiled in with --dart-define at build time. It is what proves
// the page you are looking at came from this deploy rather than from a cache.
import 'package:flutter/material.dart';

void main() => runApp(const CupCounterApp());

const buildStamp = String.fromEnvironment('BUILD_STAMP', defaultValue: 'local build');

class CupCounterApp extends StatelessWidget {
  const CupCounterApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Web on Back4app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF208AEC)),
          useMaterial3: true,
        ),
        home: const HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _cups = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Web on Back4app')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cups counted', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Text('$_cups', style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => setState(() => _cups++),
                  icon: const Icon(Icons.local_cafe_outlined),
                  label: const Text('Pour another'),
                ),
                const SizedBox(height: 40),
                const Divider(),
                const SizedBox(height: 12),
                SelectableText('Build: $buildStamp'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
