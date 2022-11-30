import 'dart:async';

import 'package:flutter/widgets.dart';

typedef MultiStreamWidgetBuilder<T> = Widget Function(BuildContext context);

class MultiStreamBuilder extends StatefulWidget {
  const MultiStreamBuilder({
    required this.streams,
    required this.builder,
    Key? key,
  }) : super(key: key);

  final List<Stream<dynamic>> streams;
  final MultiStreamWidgetBuilder builder;

  Widget build(BuildContext context) => builder(context);

  @override
  State<MultiStreamBuilder> createState() => _MultiStreamBuilderState();
}

class _MultiStreamBuilderState extends State<MultiStreamBuilder> {
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(MultiStreamBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.streams != widget.streams) {
      _unsubscribe();
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    for (final s in widget.streams) {
      final subscription = s.listen(
        (dynamic data) {
          setState(() {});
        },
        onError: (Object error, StackTrace stackTrace) {
          setState(() {});
        },
        onDone: () {
          setState(() {});
        },
      );
      _subscriptions.add(subscription);
    }
  }

  void _unsubscribe() {
    for (final s in _subscriptions) {
      s.cancel();
    }
    _subscriptions.clear();
  }
}
