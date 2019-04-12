import './person.dart';
import './task_row.dart';
import 'package:flutter/material.dart';

class ListModel {
  ListModel(this.listKey, items,this.onTap) : this.items = new List.of(items);

  final GlobalKey<AnimatedListState> listKey;
  final List<QMPersonItem> items;
  final void Function(BuildContext,QMPersonItem) onTap;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, QMPersonItem item) {
    items.insert(index, item);
    _animatedList.insertItem(index, duration: new Duration(milliseconds: 150));
  }

  QMPersonItem removeAt(int index) {
    final QMPersonItem removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (context, animation) => new TaskRow(
              task: removedItem,
              animation: animation,
              onTap: onTap,
            ),
        duration: new Duration(milliseconds: (150 + 200*(index/length)).toInt())
      );
    }
    return removedItem;
  }

  int get length => items.length;

  QMPersonItem operator [](int index) => items[index];

  int indexOf(QMPersonItem item) => items.indexOf(item);
}
