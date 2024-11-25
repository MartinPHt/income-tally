import 'package:flutter/cupertino.dart';
import 'package:income_tally/services/data_controller.dart';

class StateAwareWidget extends StatelessWidget {
  final Widget successWidget;
  final Widget onLoadingWidget;
  final Widget onErrorWidget;
  final ValueNotifier<DataState> notifier;

  const StateAwareWidget({super.key, required this.successWidget, required this.onLoadingWidget, required this.onErrorWidget, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: notifier, builder: (context, state, child) {
      if (state == DataState.loaded) {
        return successWidget;
      }
      else if (state == DataState.loading) {
        return onLoadingWidget;
      }
      else {
        return onErrorWidget;
      }
    });
  }

}