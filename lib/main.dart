import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:film_list_third/backend/hive/film_item_type_keys.dart';
import 'package:film_list_third/frontend/app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(FilmItemTypeAdapter());
  Hive.registerAdapter(UserThemeDataTypeAdapter());

  await Hive.openBox<FilmItemType>(FilmItemTypeKeys.filmItemTypeKey);
  await Hive.openBox<UserThemeDataType>(FilmItemTypeKeys.userThemeDataTypeKey);

  runApp(const FilmListAppStart());

}

