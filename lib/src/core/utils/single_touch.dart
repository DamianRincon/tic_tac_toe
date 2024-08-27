import 'package:flutter/gestures.dart';

class SingleTouchTapGestureRecognizer extends TapGestureRecognizer {
  final Set<int> _activePointers = <int>{};

  @override
  void addPointer(PointerDownEvent event) {
    if (_activePointers.isEmpty) {
      super.addPointer(event);
    }

    _activePointers.add(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _activePointers.remove(event.pointer);
    }

    if (_activePointers.length == 1) {
      super.handleEvent(event);
    }
  }
}
