import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speech extends StatefulWidget {
  const Speech({super.key});

  @override
  State<Speech> createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = 'Tap the microphone to start listening...';
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            _speechEnabled ? _lastWords : 'Speech not available',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _speechToText.isListening,
        endRadius: 50,
        repeat: true,
        glowColor: Colors.black,
        duration: const Duration(milliseconds: 800),
        repeatPauseDuration: const Duration(milliseconds: 800),
        child: FloatingActionButton(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speechToText.isListening ? Icons.mic_off : Icons.mic)),
      ),
    );
  }
}
