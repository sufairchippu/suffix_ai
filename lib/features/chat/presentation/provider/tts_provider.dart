import 'package:clean_architutre_learn/core/service/speach/speech_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

enum TtsState { idle, playing, stopped }

class TtsNotifier extends StateNotifier<TtsState> {
  final FlutterTts _flutterTts = FlutterTts();

  TtsNotifier() : super(TtsState.idle) {
    _initTts();
  }

  void _initTts() {
    _flutterTts.setStartHandler(() {
      state = TtsState.playing;
    });

    _flutterTts.setCompletionHandler(() {
      state = TtsState.idle;
    });

    _flutterTts.setCancelHandler(() {
      state = TtsState.stopped;
    });

    _flutterTts.setErrorHandler((msg) {
      state = TtsState.idle;
    });
  }

  Future<void> speak(String text) async {
    await _flutterTts.stop();
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setVoice({
      "name": "com.apple.voice.compact.en-US.Samantha",
      "locale": "en-US",
    });
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    state = TtsState.stopped;
  }
}

final ttsProvider = StateNotifierProvider<TtsNotifier, TtsState>((ref) {
  return TtsNotifier();
});

final voiceListenProvider = StateProvider<bool>((ref) {
  return false;
});


final speechNotifierProvider =
    StateNotifierProvider<SpeechNotifier, bool>((ref) {
  return SpeechNotifier();
});

class SpeechNotifier extends StateNotifier<bool> {
  final _speechService = SpeechService();

  SpeechNotifier() : super(false);

  Future<void> init() async {
    await Permission.microphone.request();
    await Permission.speech.request();
    await _speechService.initialize();
  }

  void toggleListening(Function(String) onText) async {
    if (state) {
      _speechService.stopListening();
      state = false;
    } else {
      _speechService.startListening(onText);
      state = true;
    }
  }
}