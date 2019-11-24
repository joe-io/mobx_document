import 'package:flutter/foundation.dart';

class UndoItem {
  final String name;
  final Map<String, dynamic> before;
  final Map<String, dynamic> after;

  UndoItem(this.name, {@required this.before, @required this.after});
}