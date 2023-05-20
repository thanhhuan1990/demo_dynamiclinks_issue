import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _dynamicData = '';

  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: 'https://intelnet.page.link/hyPt4YMVbtuqnmfy7');
  }

  void _incrementCounter(String value) async {
    final result = await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(value));
    setState(() {
      _dynamicData = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'My Shortlink:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                  contentPadding: EdgeInsets.all(8),
                  isDense: true,
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                controller: _textController,
                onSubmitted: (str) => _incrementCounter(str),
              ),
              const SizedBox(height: 24),
              Text(
                'PendingDynamicData:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                '"$_dynamicData"',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(_textController.text),
        tooltip: 'Parse',
        child: const Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
