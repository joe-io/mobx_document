import 'package:mobx/mobx.dart';
import 'undo_item.dart';


mixin DocumentMixin<T> {
  /// The root object that this document tracks
  final _root = Observable<T>(null);
  T get root => _root.value;
  set root(T newRoot) => _root.value = newRoot;

  /// The stack of undo items
  final ObservableList<UndoItem> undoStack = ObservableList<UndoItem>();

  /// The stack of redo items - items are pushed from the undo to the redo stack when doing an undo
  final ObservableList<UndoItem> redoStack = ObservableList<UndoItem>();

  /// Must be implemented in the class that includes this Mixin - returns a new instance of the root object from JSON
  T rootFromJson(Map<String, dynamic> json);

  /// Must be implemented in the class that includes this Mixin - serializes an instance to JSON
  Map<String, dynamic> rootToJson(T obj);

  Map<String, dynamic> _currentState;

  /// Snapshots the state of the entire document and pushes it to the undo stack
  undoableAction(String action, Function fn) => _executeInAction((){
    final before = _currentState ?? rootToJson(root);
    fn();
    _currentState = rootToJson(root);
    // Push the change to the undo stack
    undoStack.insert(0, UndoItem(action, before: before, after: _currentState));
    // Reset the redoStack - e.g. if you undo and then change something, redo should be cleared
    redoStack.clear();
  });

  /// Undoes the last action
  /// Example Undo/Redo Stack
  ///
  ///  1) Changes: A,B,C
  ///  undo: A,B
  ///  current: C
  ///  redo: -
  ///
  ///  2) Undo: A,B
  ///  undo: A
  ///  current: B
  ///  redo: C
  ///
  ///  3) Undo: A
  ///  undo: -
  ///  current: A
  ///  redo: B,C
  ///
  undo() => _executeInAction((){
    if (undoStack.length == 0) return;

    final undoItem = undoStack.removeAt(0);
    redoStack.insert(0, undoItem);

    // Pop the top undo stack item
//    current = undoStack.removeAt(0);

    // Update root to the undo state
    root = rootFromJson(undoItem.before);
  });

  /// Redoes the last undo
  redo() => _executeInAction((){
    if (redoStack.length == 0) return;

    final redoItem = redoStack.removeAt(0);
    undoStack.insert(0, redoItem);

    // Pop the top undo stack item
//    current = undoStack.removeAt(0);

    // Update root to the undo state
    root = rootFromJson(redoItem.after);
  });

  final _$_DocumentMixinActionController = ActionController(name: 'DocumentMixin');

  void _executeInAction(Function fn) {
    final _$actionInfo = _$_DocumentMixinActionController.startAction();
    try {
      fn();
    } finally {
      _$_DocumentMixinActionController.endAction(_$actionInfo);
    }
  }

  printStackTopItems(String title) {

    print("---- $title ----- ");

    print("Undo Stack:");
    undoStack.length > 0 ? _printUndoItem(undoStack[0]) : print('empty');

    print("Redo Stack:");
    redoStack.length > 0 ? _printUndoItem(redoStack[0]) : print('empty');

  }

  _printUndoItem(UndoItem item) {
    print(item.name);
    print("Before:");
    print(item.before);
    print("After:");
    print(item.after);
  }

}
