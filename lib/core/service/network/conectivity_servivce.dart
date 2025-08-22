import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConectivityServivce {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  final StreamController<ConnectivityResult> _connectivityStreamController =
      StreamController<ConnectivityResult>.broadcast();
  ConectivityServivce() {
    _initializeConnectivityStatus();
    _subscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        if (results.isNotEmpty && !_connectivityStreamController.isClosed) {
          _connectivityStreamController.add(results.first);
        }
      },
      onError: (error) {
        debugPrint('Connectivity error: $error');
      },
    );
  }

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivityStreamController.stream;

  void _initializeConnectivityStatus() async {
    try {
      final List<ConnectivityResult> results = await _connectivity
          .checkConnectivity();
      if (results.isNotEmpty && !_connectivityStreamController.isClosed) {
        _connectivityStreamController.add(results.first);
      }
    } catch (e) {
      debugPrint('Failed to get connectivity: $e');
    }
  }

  void dispose() {
    _subscription.cancel();
    _connectivityStreamController.close();
  }
}
