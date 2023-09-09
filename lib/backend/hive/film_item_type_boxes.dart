import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:film_list_third/backend/hive/film_item_type_keys.dart';
import 'package:hive/hive.dart';

class HiveBoxes{
  static Box<FilmItemType> filmItemType = Hive.box<FilmItemType>(FilmItemTypeKeys.filmItemTypeKey);
  static Box<UserThemeDataType> userThemeDataType = Hive.box<UserThemeDataType>(FilmItemTypeKeys.userThemeDataTypeKey);
}