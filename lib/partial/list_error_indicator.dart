import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// ignore: implementation_imports
import 'package:infinite_scroll_pagination/src/defaults/first_page_exception_indicator.dart';

class ListErrorIndicator extends StatelessWidget {
  final PagingController pagingController;

  const ListErrorIndicator({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    String errorMessage = 'The application has encountered an unknown error.\nPlease try again later.';

    final error = pagingController.error;
    if (error is GrpcError) {
      errorMessage = error.message ?? errorMessage;
    }

    return FirstPageExceptionIndicator(
      title: 'Something went wrong',
      message: errorMessage,
      onTryAgain: pagingController.refresh,
    );
  }
}
