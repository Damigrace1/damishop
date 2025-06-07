import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatefulWidget {
  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.successBody,
    this.errorBody,
    this.loadingBody,
    this.refresh,
  });

  final Future<T> Function() future;

  final Widget Function(T data) successBody;
  final Widget? errorBody;
  final Widget? loadingBody;
  final VoidCallback? refresh;

  @override
  State<CustomFutureBuilder<T>> createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  @override
  void didUpdateWidget(covariant CustomFutureBuilder<T> oldWidget) {
    if (oldWidget.future != widget.future) {
      _initFuture();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initFuture() {
    _future = widget.future();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return widget.errorBody ??
                Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data;
          if (data == null) {
            return widget.errorBody ??
                const Center(child: Text('Something went wrong'));
          }
          if (data is List && data.isEmpty) {
            return const Center(child: Text('Nothing here for now.'));
          }
          return widget.successBody(data);
        } else {
          return widget.loadingBody ??
              const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
