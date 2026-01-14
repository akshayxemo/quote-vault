import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextSizeProvider extends ChangeNotifier {
  static const String _textSizeKey = 'quote_text_size';
  static const double _defaultTextSize = 16.0;
  static const double _minTextSize = 8.0;
  static const double _maxTextSize = 18.0;

  double _textSize = _defaultTextSize;
  final SharedPreferences _prefs;

  TextSizeProvider(this._prefs) {
    _loadTextSize();
  }

  double get textSize => _textSize;
  double get minTextSize => _minTextSize;
  double get maxTextSize => _maxTextSize;

  void _loadTextSize() {
    _textSize = _prefs.getDouble(_textSizeKey) ?? _defaultTextSize;
    notifyListeners();
  }

  Future<void> setTextSize(double size) async {
    if (size < _minTextSize || size > _maxTextSize) return;
    
    _textSize = size;
    await _prefs.setDouble(_textSizeKey, size);
    notifyListeners();
  }

  String getTextSizeLabel() {
    if (_textSize <= 10) return 'Small';
    if (_textSize <= 14) return 'Medium';
    return 'Large';
  }
}
