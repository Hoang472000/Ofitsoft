import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///Widget lắng nghe sự kiện cuộn của list
class ScrollNotificationListener extends StatelessWidget {
  final VoidCallback? onForward;
  final VoidCallback? onReverse;
  final Widget child;

  const ScrollNotificationListener({
    Key? key, this.onForward, this.onReverse, required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      child:  child,
      onNotification: (notification) {
        final ScrollDirection direction = notification.direction;
        if(direction == ScrollDirection.reverse) {
          onReverse?.call();
        } else if (direction == ScrollDirection.forward) {
          onForward?.call();
        }
        return true;
      },
    );
  }
}
