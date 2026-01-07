import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:moonlang_dictionary/const/theme_const.dart';
import 'package:moonlang_dictionary/view_model/base/base_view_model.dart';
 
class ThemeVm extends BaseViewModel {
  ThemeVm() : super(BaseViewModelState());

  ThemeData _theme = ThemeDataConstants.light;

  ThemeData get getTheme => _theme;
  void toggleTheme() {
    setState(viewState: ViewState.busy);
    final isDarkMode = _theme == ThemeDataConstants.dark;
    if (isDarkMode) {
      _theme = ThemeDataConstants.light;
    } else {
      _theme = ThemeDataConstants.dark;
    }
    setState(viewState: ViewState.done);
  }
}

final themeVmProvider = StateNotifierProvider<ThemeVm, BaseViewModelState>(
  (ref) => ThemeVm(),
);
