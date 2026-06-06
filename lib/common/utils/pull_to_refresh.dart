import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> refreshBlocState<S>({
  required BlocBase<S> bloc,
  required VoidCallback dispatch,
  required bool Function(S state) isLoading,
  Duration timeout = const Duration(seconds: 20),
}) async {
  dispatch();

  if (!isLoading(bloc.state)) return;

  try {
    await bloc.stream.firstWhere((state) => !isLoading(state)).timeout(timeout);
  } catch (_) {
    // Best-effort refresh: we do not block the UI if the stream times out.
  }
}
