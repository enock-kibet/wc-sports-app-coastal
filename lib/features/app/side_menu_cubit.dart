import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenuCubit extends Cubit<GlobalKey<ScaffoldState>> {
  SideMenuCubit() : super(GlobalKey<ScaffoldState>());

  void openDrawer() {
    print("open drawer : ${state.currentState!.isDrawerOpen}");
    if (!state.currentState!.isDrawerOpen) {
      state.currentState!.openDrawer();
    }
  }

  void closeDrawer() {
    if (state.currentState!.isDrawerOpen) {
      state.currentState!.closeDrawer();
    }
  }
}
class HideCubit extends Cubit<bool> {
  HideCubit() : super(false);

  void reveal() {
    emit(true);
  }

  void hide() {
    emit(false);
  }
}