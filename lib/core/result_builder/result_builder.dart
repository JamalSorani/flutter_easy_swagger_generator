import 'result.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResultBuilder<T> extends StatelessWidget {
  ResultBuilder({
    super.key,
    required this.success,
    this.loading,
    this.onError,
    this.init,
    required this.result,
  });

  final Result<T> result;
  Widget Function()? loading;
  final Widget Function(T data) success;
  final Function()? onError;
  Widget Function()? init;

  @override
  Widget build(BuildContext context) {
    Widget? next;

    loading ??= () => const Center(
          child: CircularProgressIndicator(),
        );
    init ??= () => const SizedBox();
    result.when(
      init: () => next = const SizedBox(),
      loading: () => next = loading!(),
      loaded: (data) => next = success(data),
      error: (message) => onError != null
          ? {
              next = const SizedBox(),
            }
          : const SizedBox.shrink(),
    );
    return next ?? const SizedBox();
  }
}

