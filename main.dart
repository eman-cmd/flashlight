import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const FlashlightApp());
}

class FlashlightApp extends StatelessWidget {
  const FlashlightApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      title: 'Flashlight App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pinkAccent, // Change to a light, pretty color
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const FlashlightHomePage(),
    );
  }
}

class FlashlightHomePage extends StatefulWidget {
  const FlashlightHomePage({Key? key}) : super(key: key);

  @override
  _FlashlightHomePageState createState() => _FlashlightHomePageState();
}

class _FlashlightHomePageState extends State<FlashlightHomePage> {
  bool _isTorchOn = false;

  void _toggleTorch() async {
    try {
      if (_isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        _isTorchOn = !_isTorchOn;
      });
    } catch (e) {
      _showErrorDialog('Error', 'Could not access the flashlight. Make sure permissions are granted.');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashlight'),
        backgroundColor: Colors.pinkAccent, // Change to a light, pretty color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            GestureDetector(
              onTap: _toggleTorch,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isTorchOn ? Colors.yellow : Colors.grey[800],
                  boxShadow: [
                    BoxShadow(
                      color: _isTorchOn ? Colors.yellowAccent.withOpacity(0.6) : Colors.black45,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                height: 150,
                width: 150,
                child: Icon(
                  _isTorchOn ? Icons.flashlight_on : Icons.flashlight_off,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between the button and text
            const Text(
              'Flashlight',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
