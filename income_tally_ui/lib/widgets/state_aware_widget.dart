import 'package:flutter/cupertino.dart';
import 'package:income_tally/services/data_controller.dart';

class StateAwareWidget extends StatelessWidget {
  final ValueNotifier<DataState> notifier;
  final Widget successWidget;
  final Widget onLoadingWidget;
  final Widget onErrorWidget;

  const StateAwareWidget({super.key, required this.notifier, required this.successWidget, required this.onLoadingWidget, required this.onErrorWidget});

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