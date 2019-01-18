import 'package:flutter/material.dart';

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
              (BuildContext context, Animation<double> animation) {
            return removedItemBuilder(removedItem, context, animation);
          });
    }
    return removedItem;
  }

  int get length => items.length;

  E operator [](int index) => items[index];

  int indexOf(E item) => items.indexOf(item);
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {

  const CardItem(
      {Key key,
        @required this.animation,
        this.onTap,
        @required this.item,
        this.selected: false, this.child})
      : assert(animation != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
