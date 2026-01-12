import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:force_english_ime/force_english_ime.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _platformVersion = 'Unknown';
  String _imeStatus = 'Unknown';
  final _forceEnglishImePlugin = ForceEnglishIme();
  final _emailController = TextEditingController();
  final _normalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _forceEnglishImePlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    _checkImeStatus();
  }

  Future<void> _checkImeStatus() async {
    try {
      final isEnglish = await _forceEnglishImePlugin.isEnglishIme();
      setState(() {
        _imeStatus = isEnglish ? 'English Mode' : 'Chinese/IME Mode';
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('_imeStatus：$_imeStatus')));
    } catch (e) {
      setState(() {
        _imeStatus = 'Error: $e';
      });
    }
  }

  Future<void> _forceEnglish() async {
    try {
      final success = await _forceEnglishImePlugin.forceEnglishInput();
      if (success) {
        _checkImeStatus();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Forced to English input')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _restore() async {
    try {
      final success = await _forceEnglishImePlugin.restoreOriginalIme();
      if (success) {
        _checkImeStatus();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Restored original IME')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _normalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Force English IME Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Running on: $_platformVersion'),
            const SizedBox(height: 8),
            Text('Current IME Status: $_imeStatus'),
            const SizedBox(height: 24),
            const Text(
              'Email Input (Force English):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  _forceEnglish();
                } else {
                  _restore();
                }
              },
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter email (English only)',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Normal Input (No restriction):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _normalController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter anything',
                labelText: 'Normal Input',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _forceEnglish,
                  child: const Text('Force English'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _restore,
                  child: const Text('Restore IME'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _checkImeStatus,
                  child: const Text('Check Status'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
