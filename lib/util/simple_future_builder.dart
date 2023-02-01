import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SimpleFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final T? initialData;
  Widget Function(BuildContext context, Object? error) onErrorBuilder;
  final Widget Function(BuildContext context, T data) onLoadedBuilder;
  final WidgetBuilder onLoadingBuilder;

  SimpleFutureBuilder({
    Key? key,
    required this.future,
    this.initialData,
    Widget Function(BuildContext context, Object? error)? onErrorBuilder,
    required this.onLoadedBuilder,
    required this.onLoadingBuilder,
  })  : onErrorBuilder = onErrorBuilder ??
            ((BuildContext context, Object? error) => Text(
                  (error ?? 'Unknown Error Occurred').toString(),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                )),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        initialData: initialData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return onLoadedBuilder(context, snapshot.requireData);
            } else {
              return onErrorBuilder(context, snapshot.error);
            }
          } else {
            return onLoadingBuilder(context);
          }
        });
  }
}
