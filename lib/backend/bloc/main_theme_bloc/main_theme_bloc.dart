import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:film_list_third/backend/hive/film_item_type_boxes.dart';
import 'package:film_list_third/frontend/mobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

part 'main_theme_event.dart';
part 'main_theme_state.dart';

class MainThemeBloc extends Bloc<MainThemeEvent, MainThemeState> {
  MainThemeBloc() : super(MainThemeInitial()) {
    on<MainThemeEventLoad>(_load);
    on<MainThemeEventChange>(_change);
  }

  ThemeData _findTheme(bool isDarkMode, Color color) {
    if (isDarkMode == true) {
      if (color.value == AppTheme.darkDefault.primaryColorLight.value) {
        return AppTheme.darkDefault;
      }
      if (color.value == AppTheme.darkRedTheme.primaryColorLight.value) {
        return AppTheme.darkRedTheme;
      }
      if (color.value == AppTheme.darkYellowTheme.primaryColorLight.value) {
        return AppTheme.darkYellowTheme;
      }
      if (color.value == AppTheme.darkGreenTheme.primaryColorLight.value) {
        return AppTheme.darkGreenTheme;
      }
      if (color.value == AppTheme.darkBlueTheme.primaryColorLight.value) {
        return AppTheme.darkBlueTheme;
      }
    } else {
      if (color.value == AppTheme.lightDefault.primaryColorLight.value) {
        return AppTheme.lightDefault;
      }
      if (color.value == AppTheme.lightRedTheme.primaryColorLight.value) {
        return AppTheme.lightRedTheme;
      }
      if (color.value == AppTheme.lightYellowTheme.primaryColorLight.value) {
        return AppTheme.lightYellowTheme;
      }
      if (color.value == AppTheme.lightGreenTheme.primaryColorLight.value) {
        return AppTheme.lightGreenTheme;
      }
      if (color.value == AppTheme.lightBlueTheme.primaryColorLight.value) {
        return AppTheme.lightBlueTheme;
      }
    }

    return AppTheme.darkYellowTheme;
  }

  Future<void> _load(
    MainThemeEventLoad event,
    Emitter emit,
  ) async {
    try {
      if (HiveBoxes.userThemeDataType.values.isEmpty) {
        var brightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;

        if (brightness == Brightness.dark) {
          HiveBoxes.userThemeDataType.add(UserThemeDataType(
            color: AppTheme.darkDefault.primaryColorLight.value,
            isDarkMode: true,
          ));
          emit(MainThemeLoaded(theme: AppTheme.darkDefault));
        } else {
          HiveBoxes.userThemeDataType.add(UserThemeDataType(
            color: AppTheme.lightDefault.primaryColorLight.value,
            isDarkMode: true,
          ));
          emit(MainThemeLoaded(theme: AppTheme.lightDefault));
        }
      } else {
        Color color = Color(HiveBoxes.userThemeDataType.values.first.color);
        bool isDarkMode = HiveBoxes.userThemeDataType.values.first.isDarkMode;

        emit(MainThemeLoaded(theme: _findTheme(isDarkMode, color)));
      }
    } catch (e) {
      e;
    }
  }

  Future<void> _change(
    MainThemeEventChange event,
    Emitter emit,
  ) async {
    try {
      HiveBoxes.userThemeDataType.clear();
      HiveBoxes.userThemeDataType.add(UserThemeDataType(
        color: event.theme.primaryColorLight.value,
        isDarkMode: event.theme.brightness == Brightness.dark,
      ));
      emit(MainThemeLoaded(theme: event.theme));
    } catch (e) {
      e;
    }
  }
}
