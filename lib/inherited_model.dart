import 'package:flutter/widgets.dart';

import 'shared_value.dart';

class GlobalStateInheritedModel extends InheritedModel<SharedValue> {
  final Map<SharedValue, double> stateNonceMap;

  const GlobalStateInheritedModel({
    Key key,
    Widget child,
    @required this.stateNonceMap,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  @override
  bool updateShouldNotifyDependent(
    GlobalStateInheritedModel oldWidget,
    Set<SharedValue> dependencies,
  ) {
    for (var state in dependencies) {
      // Compare the nonce value of this GlobalState,
      // with an older nonce value of the same GlobalState object.
      //
      // If the nonce values are not same,
      // we assume that the internal state value must have changed as well.
      if (state.nonce != oldWidget.stateNonceMap[state]) {
        return true;
      }
    }
    return false;
  }
}
