import 'package:flutter/foundation.dart';

import '../../data/today_repository.dart';
import '../../domain/today_models.dart';

class TodayController extends ChangeNotifier {
  TodayController(this._repository);

  final TodayRepository _repository;

  TodayData? _data;
  bool _loading = false;
  int _remainingSeconds = 25 * 60;

  TodayData? get data => _data;
  bool get loading => _loading;
  int get remainingSeconds => _remainingSeconds;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _data = await _repository.loadToday();
    _loading = false;
    notifyListeners();
  }

  void startFocusSession() {
    _remainingSeconds = 25 * 60;
    notifyListeners();
  }
}
