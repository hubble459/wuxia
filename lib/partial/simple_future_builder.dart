import 'package:flutter/material.dart';

typedef ErrorBuilder = Widget Function(BuildContext context, Object? error);

Widget defaultErrorBuilder(BuildContext context, Object? error) {
  return Center(
    child: Column(
      children: [
        Text(
          (error ?? 'Unknown Error Occurred').toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        ElevatedButton(
          onPressed: () {
            SimpleFutureBuilder widget = context.widget as SimpleFutureBuilder;
            widget.build(context);
          },
          child: const Text('Retry'),
        ),
      ],
    ),
  );
}

Widget defaultLoadingBuilder(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

class SimpleFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final T? initialData;
  final ErrorBuilder onErrorBuilder;
  final Widget Function(BuildContext context, T data) onLoadedBuilder;
  final WidgetBuilder onLoadingBuilder;

  const SimpleFutureBuilder({
    Key? key,
    required this.future,
    this.initialData,
    this.onErrorBuilder = defaultErrorBuilder,
    this.onLoadingBuilder = defaultLoadingBuilder,
    required this.onLoadedBuilder,
  }) : super(key: key);

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
      },
    );
  }
}
