import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() => runApp(const Main());

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _on = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: _on ? const ColorScheme.light() : const ColorScheme.dark(),
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: TorchLight.isTorchAvailable(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Center(
                  child: FloatingActionButton.large(
                    onPressed: () {
                      _on ? TorchLight.disableTorch() : TorchLight.enableTorch();
                      setState(() => _on = !_on);
                    },
                    child: const Icon(Icons.power_settings_new),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('No flashlight D:'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
